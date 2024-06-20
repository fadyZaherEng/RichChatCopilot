import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:rich_chat_copilot/lib/src/core/utils/constants.dart';
import 'package:rich_chat_copilot/lib/src/core/utils/massage_type.dart';
import 'package:rich_chat_copilot/lib/src/data/source/local/single_ton/firebase_single_ton.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/chat/last_massage.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/chat/massage.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/chat/massage_reply.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/login/user.dart';
import 'package:uuid/uuid.dart';

part 'chats_event.dart';

part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  ChatsBloc() : super(ChatsInitial()) {
    on<GetAllUsersEvent>(_onGetAllUsersEvent);
    on<GetCurrentUserEvent>(_onGetCurrentUserEvent);
    on<SendTextMessageEvent>(_onSendTextMessageEvent);
  }

  //replay message
  MassageReply? _massageReply;

  MassageReply? get massageReply => _massageReply;

  void setMassageReply(MassageReply? massageReply) {
    _massageReply = massageReply;
    //notifyListeners();
    emit(SetMassageReplyState(massageReply: massageReply));
  }

  FutureOr<void> _onGetAllUsersEvent(
      GetAllUsersEvent event, Emitter<ChatsState> emit) async {
    emit(GetUserChatsLoading());
    try {
      List<UserModel> users = [];
      await FirebaseSingleTon.db
          .collection("users")
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          users.add(UserModel.fromJson(doc.data() as Map<String, dynamic>));
        }
      });
      emit(GetUserChatsSuccess(users: users));
    } catch (e) {
      emit(GetUserChatsError(message: e.toString()));
    }
  }

  FutureOr<void> _onGetCurrentUserEvent(
      GetCurrentUserEvent event, Emitter<ChatsState> emit) async {
    emit(GetCurrentUserChatsLoading());
    try {
      UserModel user = UserModel();
      DocumentSnapshot doc = await FirebaseSingleTon.db
          .collection(Constants.users)
          .doc(event.uid)
          .get();
      user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
      emit(GetCurrentUserChatsSuccess(user: user));
    } catch (e) {
      emit(GetCurrentUserChatsError(message: e.toString()));
    }
  }

  FutureOr<void> _onSendTextMessageEvent(
      SendTextMessageEvent event, Emitter<ChatsState> emit) async {
    emit(SendTextMessageLoading());
    //generate id to massage
    var massageId = Uuid().v4();
    //check if massage is reply then add replied message to massage
    String repliedMessage = _massageReply?.massage ?? "";
    String repliedTo = _massageReply == null
        ? ""
        : _massageReply!.isMe
            ? "You"
            : _massageReply!.senderName;
    MassageType repliedMessageType =
        _massageReply?.massageType ?? MassageType.text;
    //update massage model with replied message
    final massage = Massage(
      senderId: event.sender.uId,
      senderName: event.sender.name,
      senderImage: event.sender.image,
      receiverId: event.receiverId,
      massage: event.message,
      massageType: event.massageType,
      timeSent: DateTime.now(),
      messageId: massageId,
      isSeen: false,
      repliedMessage: repliedMessage,
      repliedTo: repliedTo,
      repliedMessageType: repliedMessageType,
    );
    //check if group massage and send to group else send to contact
    if (event.groupId.isNotEmpty) {
      //handle group massage
    } else {
      //handle contact massage
      await _handleContactMassage(
        massage: massage,
        receiverId: event.receiverId,
        receiverName: event.receiverName,
        receiverImage: event.receiverImage,
        success: () {
          emit(SendTextMessageSuccess());
        },
        failure: () {
          emit(SendTextMessageError(message: "Failed to send message"));
        },
      );
    }
    //emit success
    emit(SendTextMessageSuccess());
    try {} catch (e) {
      emit(SendTextMessageError(message: e.toString()));
    }
  }

  Future<void> _handleContactMassage({
    required Massage massage,
    required String receiverId,
    required String receiverName,
    required String receiverImage,
    required void Function() success,
    required void Function() failure,
  }) async {
    final receiverMassage = massage.copyWith(receiverId: massage.senderId);
    //1-initialize last massage for sender
    final senderLastMassage = LastMassage(
      massage: massage.massage,
      senderId: massage.senderId,
      receiverId: receiverId,
      receiverName: receiverName,
      receiverImage: receiverImage,
      massageType: massage.massageType,
      timeSent: massage.timeSent,
      isSeen: false,
    );
    //2-initialize last massage for receiver
    final receiverLastMassage = senderLastMassage.copyWith(
      receiverId: massage.senderId,
      receiverName: massage.senderName,
      receiverImage: massage.senderImage,
    );
    //3-send massage to receiver
    //4-send massage to sender
    //5-send last massage to receiver
    //6-send last massage to sender
    await FirebaseSingleTon.db.runTransaction((transaction) async {
      //1-send massage to receiver
      transaction.set(
        FirebaseSingleTon.db
            .collection(Constants.users)
            .doc(receiverId)
            .collection(Constants.chats)
            .doc(massage.senderId)
            .collection(Constants.messages)
            .doc(massage.messageId),
        receiverMassage.toJson(),
      );
      //2-send massage to sender
      transaction.set(
        FirebaseSingleTon.db
            .collection(Constants.users)
            .doc(massage.senderId)
            .collection(Constants.chats)
            .doc(receiverId)
            .collection(Constants.messages)
            .doc(massage.messageId),
        massage.toJson(),
      );
      //3-send last massage to receiver
      transaction.set(
        FirebaseSingleTon.db
            .collection(Constants.users)
            .doc(receiverId)
            .collection(Constants.chats)
            .doc(massage.senderId),
        receiverLastMassage.toJson(),
      );
      //4-send last massage to sender
      transaction.set(
        FirebaseSingleTon.db
            .collection(Constants.users)
            .doc(massage.senderId)
            .collection(Constants.chats)
            .doc(receiverId),
        senderLastMassage.toJson(),
      );
    }).then((value) {
      success();
    }).catchError((error) {
      failure();
    });
    //call success
  }

  //get chats last massages stream
  Stream<List<LastMassage>> getChatsLastMassagesStream(
      {required String userId}) {
    return FirebaseSingleTon.db
        .collection(Constants.users)
        .doc(userId)
        .collection(Constants.chats)
        .orderBy("timeSent", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => LastMassage.fromJson(doc.data()))
          .toList();
    });
  }

  //get massages stream
  Stream<List<Massage>> getMessagesStream({
    required String userId,
    required String receiverId,
    required String isGroup,
  }) {
    if (isGroup.isNotEmpty) {
      return FirebaseSingleTon.db
          .collection(Constants.groups)
          .doc(receiverId)
          .collection(Constants.messages)
          .orderBy("timeSent", descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => Massage.fromJson(doc.data()))
            .toList();
      });
    } else {
      //handle contact massage
      return FirebaseSingleTon.db
          .collection(Constants.users)
          .doc(userId)
          .collection(Constants.chats)
          .doc(receiverId)
          .collection(Constants.messages)
          .orderBy("timeSent", descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => Massage.fromJson(doc.data()))
            .toList();
      });
    }
  }
}
