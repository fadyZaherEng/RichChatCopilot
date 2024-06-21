import 'dart:io';

import 'package:date_format/date_format.dart' as df;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rich_chat_copilot/generated/l10n.dart';
import 'package:rich_chat_copilot/lib/src/config/theme/color_schemes.dart';
import 'package:rich_chat_copilot/lib/src/core/base/widget/base_stateful_widget.dart';
import 'package:rich_chat_copilot/lib/src/core/resources/image_paths.dart';
import 'package:rich_chat_copilot/lib/src/core/utils/massage_type.dart';
import 'package:rich_chat_copilot/lib/src/core/utils/permission_service_handler.dart';
import 'package:rich_chat_copilot/lib/src/core/utils/show_action_dialog.dart';
import 'package:rich_chat_copilot/lib/src/core/utils/show_bottom_sheet_upload_media.dart';
import 'package:rich_chat_copilot/lib/src/di/data_layer_injector.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/chat/massage.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/chat/massage_reply.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/login/user.dart';
import 'package:rich_chat_copilot/lib/src/domain/usecase/get_user_use_case.dart';
import 'package:rich_chat_copilot/lib/src/presentation/blocs/chats/chats_bloc.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/chat/widgets/bottom_chat_widget.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/chat/widgets/chat_app_bar_widget.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/chat/widgets/chats_list_massages_widget.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/chat/widgets/current_massage_widget.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/chat/widgets/receiver_massage_widget.dart';
import 'package:rich_chat_copilot/lib/src/presentation/widgets/build_date_widget.dart';
import 'package:rich_chat_copilot/lib/src/presentation/widgets/cricle_loading_widget.dart';

class ChatScreen extends BaseStatefulWidget {
  final String friendId;
  final String friendName;
  final String friendImage;
  final String groupId;

  const ChatScreen({
    super.key,
    required this.friendId,
    required this.friendName,
    required this.friendImage,
    required this.groupId,
  });

  @override
  BaseState<ChatScreen> baseCreateState() => _ChatScreenState();
}

class _ChatScreenState extends BaseState<ChatScreen> {
  bool _isGroupChat = false;
  TextEditingController _massageController = TextEditingController();
  ScrollController _massagesScrollController = ScrollController();
  FocusNode _massageFocusNode = FocusNode();

  ChatsBloc get _bloc => BlocProvider.of<ChatsBloc>(context);
  UserModel currentUser = UserModel();

  @override
  void initState() {
    super.initState();
    currentUser = GetUserUseCase(injector())();
    _isGroupChat = widget.groupId.isNotEmpty;
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<ChatsBloc, ChatsState>(listener: (context, state) {
      if (state is SendTextMessageSuccess) {
        _massageController.clear();
        _bloc.setMassageReply(null);
        _massageFocusNode.requestFocus();
      }
      if (state is SendTextMessageError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.message),
        ));
      } else if (state is SelectImageState) {
        _cropperImage(state.file);
      }else if(state is SendFileMessageSuccess){
        _massageController.clear();
        _bloc.setMassageReply(null);
        _massageFocusNode.requestFocus();
        // hideLoading();
      }else if(state is SendFileMessageError){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.message),
        ));
        // hideLoading();
      }
    }, builder: (context, state) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            ChatAppBarWidget(friendId: widget.friendId),
            Expanded(
              child: ChatsListMassagesWidget(
                massagesStream: _bloc.getMessagesStream(
                  receiverId: widget.friendId,
                  userId: currentUser.uId,
                  isGroup: widget.groupId,
                ),
                massagesScrollController: _massagesScrollController,
                currentUser: currentUser,
                onRightSwipe: (MassageReply massageReply) {
                  _bloc.setMassageReply(massageReply);
                },
                friendId: widget.friendId,
              ),
            ),
            const SizedBox(height: 15),
            BottomChatWidget(
              friendId: widget.friendId,
              friendName: widget.friendName,
              friendImage: widget.friendImage,
              groupId: widget.groupId,
              textEditingController: _massageController,
              focusNode: _massageFocusNode,
              isAttachedLoading: state is SendFileMessageLoading,
              isSendingLoading: state is SendTextMessageLoading,
              onTextChange: (String value) {
                _massageController.text = value;
              },
              onAttachPressed: () {
                _openMediaBottomSheet(context);
              },
              onCameraPressed: () {},
              onSendPressed: () {
                //TODO: send message
                if(_massageController.text.isNotEmpty){
                  _bloc.add(SendTextMessageEvent(
                    sender: currentUser,
                    receiverId: widget.friendId,
                    receiverName: widget.friendName,
                    receiverImage: widget.friendImage,
                    message: _massageController.text,
                    massageType: MassageType.text,
                    groupId: widget.groupId,
                  ));
                }
              },
              massageReply: _bloc.massageReply,
              setReplyMessageWithNull: () {
                _bloc.setMassageReply(null);
              },
            ),
          ],
        ),
      );
    });
  }

  void _openMediaBottomSheet(BuildContext context) async {
    await showBottomSheetUploadMedia(
      context: context,
      onTapCamera: () async {
        _navigateBackEvent();
        if (await PermissionServiceHandler().handleServicePermission(
            setting: PermissionServiceHandler.getCameraPermission())) {
          _getImage(ImageSource.camera, MassageType.image);
        } else {
          _showActionDialog(
            icon: ImagePaths.icCancel,
            onPrimaryAction: () {
              _navigateBackEvent();
              openAppSettings().then((value) async {
                if (await PermissionServiceHandler().handleServicePermission(
                    setting: PermissionServiceHandler.getCameraPermission())) {}
              });
            },
            onSecondaryAction: () {
              _navigateBackEvent();
            },
            primaryText: S.of(context).ok,
            secondaryText: S.of(context).cancel,
            text: S.of(context).youShouldHaveCameraPermission,
          );
        }
      },
      onTapGallery: () async {
        _navigateBackEvent();
        Permission permission = PermissionServiceHandler.getGalleryPermission(
          true,
          androidDeviceInfo:
              Platform.isAndroid ? await DeviceInfoPlugin().androidInfo : null,
        );
        if (await PermissionServiceHandler()
            .handleServicePermission(setting: permission)) {
          _getImage(ImageSource.gallery, MassageType.image);
        } else {
          _showActionDialog(
            icon: ImagePaths.icCancel,
            onPrimaryAction: () {
              _navigateBackEvent();
              openAppSettings().then((value) async {
                if (await PermissionServiceHandler()
                    .handleServicePermission(setting: permission)) {}
              });
            },
            onSecondaryAction: () {
              _navigateBackEvent();
            },
            primaryText: S.of(context).ok,
            secondaryText: S.of(context).cancel,
            text: S.of(context).youShouldHaveGalleryPermission,
          );
        }
      },
      onTapVideo: () async {
        // _navigateBackEvent();
        // if (await PermissionServiceHandler().handleServicePermission(
        //     setting: PermissionServiceHandler.getCameraPermission())) {
        //   _getImage(ImageSource.camera, MassageType.video);
        // } else {
        //   _showActionDialog(
        //     icon: ImagePaths.icCancel,
        //     onPrimaryAction: () {
        //       _navigateBackEvent();
        //       openAppSettings().then((value) async {
        //         if (await PermissionServiceHandler().handleServicePermission(
        //             setting: PermissionServiceHandler.getCameraPermission())) {}
        //       });
        //     },
        //     onSecondaryAction: () {
        //       _navigateBackEvent();
        //     },
        //     primaryText: S.of(context).ok,
        //     secondaryText: S.of(context).cancel,
        //     text: S.of(context).youShouldHaveCameraPermission,
        //   );
        // }
      },
      isVideo: true,
    );
  }

  void _showActionDialog({
    required String icon,
    required void Function() onPrimaryAction,
    required void Function() onSecondaryAction,
    required String primaryText,
    required String secondaryText,
    required String text,
  }) async {
    await showActionDialogWidget(
      context: context,
      text: text,
      primaryText: primaryText,
      primaryAction: () {
        onPrimaryAction();
      },
      secondaryText: secondaryText,
      secondaryAction: () {
        onSecondaryAction();
      },
      icon: icon,
    );
  }

  Future<void> _getImage(
    ImageSource img,
    MassageType massageType,
  ) async {
    // showLoading();
    if (img == ImageSource.gallery) {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: img);
      if (pickedFile == null) {
        return;
      }
      _bloc.add(SelectImageEvent(File(pickedFile.path)));
    } else {
      final ImagePicker picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: img);
      if (pickedFile == null) {
        return;
      }
      XFile? compressedImage = await compressFile(File(pickedFile.path));
      if (compressedImage == null) {
        return;
      }

      _bloc.add(SelectImageEvent(File(compressedImage.path)));
    }
  }

  Future<XFile?> compressFile(File file) async {
    final filePath = file.absolute.path;
    final lastIndex = filePath.lastIndexOf(RegExp(r'.png|.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

    if (lastIndex == filePath.lastIndexOf(RegExp(r'.png'))) {
      final compressedImage = await FlutterImageCompress.compressAndGetFile(
          filePath, outPath,
          minWidth: 1000,
          minHeight: 1000,
          quality: 50,
          format: CompressFormat.png);
      return compressedImage;
    } else {
      final compressedImage = await FlutterImageCompress.compressAndGetFile(
        filePath,
        outPath,
        minWidth: 1000,
        minHeight: 1000,
        quality: 50,
      );
      return compressedImage;
    }
  }

  Future _cropperImage(File imagePicker) async {
    if (imagePicker != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: imagePicker.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9,
        ],
        compressQuality: 100,
        cropStyle: CropStyle.rectangle,
        maxWidth: 1080,
        maxHeight: 1080,
        aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        compressFormat: ImageCompressFormat.jpg,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Theme.of(context).colorScheme.primary,
            toolbarWidgetColor: ColorSchemes.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(title: 'Cropper'),
          WebUiSettings(
            context: context,
            presentStyle: CropperPresentStyle.dialog,
            boundary: const CroppieBoundary(width: 520, height: 520),
            viewPort:
                const CroppieViewPort(width: 480, height: 480, type: 'circle'),
            enableExif: true,
            enableZoom: true,
            showZoomer: true,
          ),
        ],
      );
      if (croppedFile != null) {
        _sendFileMassage(
            massageType: MassageType.image, filePath: croppedFile.path);
      }
    }
  }

  //send file massage
  void _sendFileMassage({
    required MassageType massageType,
    required String filePath,
  }) {
    _bloc.add(
      SendFileMessageEvent(
        sender: currentUser,
        receiverId: widget.friendId,
        receiverName: widget.friendName,
        receiverImage: widget.friendImage,
        file: File(filePath),
        massageType: massageType,
        groupId: widget.groupId,
      ),
    );
  }

  @override
  void dispose() {
    _massageController.dispose();
    _massagesScrollController.dispose();
    _massageFocusNode.dispose();
    super.dispose();
  }

  void _navigateBackEvent() {
    Navigator.of(context).pop();
  }
}
