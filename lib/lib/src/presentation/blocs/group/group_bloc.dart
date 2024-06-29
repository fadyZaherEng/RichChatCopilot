import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:rich_chat_copilot/lib/src/core/utils/constants.dart';
import 'package:rich_chat_copilot/lib/src/core/utils/save_image_to_storage.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/group/group.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/login/user.dart';
import 'package:uuid/uuid.dart';

part 'group_event.dart';

part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  GroupBloc() : super(GroupInitial()) {
    on<GroupEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  bool _isLoading = false;
  bool _editSettings = false;
  bool _approveNewMembers = false;
  bool _requestToJoin = false;
  bool _lockMassages = false;
  Group? _group;

  final List<UserModel> _groupMembersList = [];
  final List<UserModel> _groupAdminsList = [];

  //getter
  bool get iSLoading => _isLoading;

  bool get editSettings => _editSettings;

  bool get approveNewMembers => _approveNewMembers;

  bool get requestToJoin => _requestToJoin;

  bool get lockMassages => _lockMassages;

  Group? get group => _group;

  List<UserModel> get groupMembersList => _groupMembersList;

  List<UserModel> get groupAdminsList => _groupAdminsList;

  //setter

  //loading
  void setLoading({required bool isLoading}) {
    _isLoading = isLoading;
    emit(GroupLoadingState());
  }

  //editSettings
  void setEditSettings({required bool editSettings}) {
    _editSettings = editSettings;
    emit(GroupEditSettingsState());
  }

  //approveNewMembers
  void setApproveNewMembers({required bool approveNewMembers}) {
    _approveNewMembers = approveNewMembers;
    emit(GroupApproveNewMembersState());
  }

  //requestToJoin
  void setRequestToJoin({required bool requestToJoin}) {
    _requestToJoin = requestToJoin;
    emit(GroupRequestToJoinState());
  }

  //lockMassages
  void setLockMassages({required bool lockMassages}) {
    _lockMassages = lockMassages;
    emit(GroupLockMassagesState());
  }

  //group
  void setGroup({required Group group}) {
    _group = group;
    emit(GroupModelState());
  }

  //groupMembersList
  void addMemberToGroup({required UserModel groupMember}) {
    _groupMembersList.add(groupMember);
    emit(GroupMembersListState());
  }

  //groupAdminsList
  void addMemberToAdmin({required UserModel groupAdmin}) {
    _groupAdminsList.add(groupAdmin);
    emit(GroupAdminsListState());
  }

  //remove member from group
  void removeMemberFromGroup({required UserModel user}) {
    _groupMembersList.remove(user);
    _groupAdminsList.remove(user);
    emit(RemoveMemberFromGroupListState());
  }

  //remove member from admins
  void removeAdminFromAdmins({required UserModel user}) {
    _groupAdminsList.remove(user);
    emit(RemoveMemberFromAdminListState());
  }

  // clear Group members
  Future clearGroupMembersList() async {
    _groupMembersList.clear();
    emit(ClearGroupMembersListState());
  }

  // clear Group admins
  Future clearGroupAdminsList() async {
    _groupAdminsList.clear();
    emit(ClearGroupAdminsListState());
  }

  //get group members uids
  List<String> getGroupMembersUIDS() {
    return _groupMembersList.map((e) => e.uId).toList();
  }

  //get group admins uids
  List<String> getGroupAdminsUIDS() {
    return _groupAdminsList.map((e) => e.uId).toList();
  }

  //create group
  Future<void> createGroup({
    required Group group,
    required File? image,
    required Function onSuccess,
    required Function(String) onError,
  }) async {
    setLoading(isLoading: true);
    emit(CreateGroupLoadingState());
    try {
      var groupId = const Uuid().v4();
      group.groupID = groupId;
      //check if file image is null
      if (image != null) {
        final imageUrl =
            await saveImageToStorage(image, "groupsImages/$groupId");
        group.groupLogo = imageUrl;
      }
      //add the group admins
      group.adminsUIDS = [group.creatorUID, ...getGroupAdminsUIDS()];
      //add the group members
      group.membersUIDS = [group.creatorUID, ...getGroupMembersUIDS()];
      //add edit settings
      group.editSettings = editSettings;
      //add approve new members
      group.approveMembers = approveNewMembers;
      //add request to join
      group.requestToJoin = requestToJoin;
      //add lock massages
      group.lockMassages = lockMassages;
      //add group to firestore
      await FirebaseFirestore.instance
          .collection(Constants.groups)
          .doc(groupId)
          .set(group.toMap());
      //on success
      onSuccess();
      setLoading(isLoading: false);
      emit(CreateGroupSuccessState());
    } catch (e) {
      setLoading(isLoading: false);
      onError(e.toString());
      emit(CreateGroupErrorState());
    }
  }

  //get stream of all private groups that contains given userId
  Stream<List<Group>> getAllPrivateGroupsStream({
    required String userId,
  }) {
    return FirebaseFirestore.instance
        .collection(Constants.groups)
        .where("membersUIDS", arrayContains: userId)
        .where("isPrivate", isEqualTo: true)
        .snapshots()
        .asyncMap(
      (event) async {
        List<Group> groups = [];
        for (var element in event.docs) {
          groups.add(Group.fromMap(element.data()));
        }
        return groups;
      },
    );
  }

//get stream of all public groups that contains given userId
  Stream<List<Group>> getAllPublicGroupsStream({
    required String userId,
  }) {
    return FirebaseFirestore.instance
        .collection(Constants.groups)
        .where("membersUIDS", arrayContains: userId)
        .where("isPrivate", isEqualTo: false)
        .snapshots()
        .asyncMap(
      (event) async {
        List<Group> groups = [];
        for (var element in event.docs) {
          groups.add(Group.fromMap(element.data()));
        }
        return groups;
      },
    );
  }

  //stream group data
  Stream<DocumentSnapshot> getGroupStream({required String groupId}) {
    return FirebaseFirestore.instance
        .collection(Constants.groups)
        .doc(groupId)
        .snapshots();
  }

  //stream users data from firestore
 Stream<List<DocumentSnapshot>> streamGroupMembersData({
    required List<String> membersUIDS,
  }) {
    return Stream.fromFuture(
      Future.wait<DocumentSnapshot>(
        membersUIDS.map<Future<DocumentSnapshot>>(
          (uid) async {
            return await FirebaseFirestore.instance
                .collection(Constants.users)
                .doc(uid)
                .get();
          },
        ),
      ),
    );
    // return FirebaseFirestore.instance
    //     .collection(Constants.users)
    //     .where("uId", whereIn: membersUIDS)
    //     .snapshots()
    //     .asyncMap(
    //   (event) async {
    //     List<UserModel> users = [];
    //     for (var element in event.docs) {
    //       users.add(UserModel.fromJson(element.data()));
    //     }
    //     return users;
    //   },
    // );
  }
}
