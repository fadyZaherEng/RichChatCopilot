import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/group/group.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/login/user.dart';

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
}
