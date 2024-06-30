part of 'group_bloc.dart';

@immutable
sealed class GroupState {}

final class GroupInitial extends GroupState {}

final class GroupLoadingState extends GroupState {}
final class GroupEditSettingsState extends GroupState {}
final class GroupApproveNewMembersState extends GroupState {}
final class GroupRequestToJoinState extends GroupState {}
final class GroupLockMassagesState extends GroupState {}
final class GroupModelState extends GroupState {}
final class GroupMembersListState extends GroupState {}
final class GroupAdminsListState extends GroupState {}
final class RemoveMemberFromGroupListState extends GroupState {}
final class RemoveMemberFromAdminListState extends GroupState {}
final class ClearGroupMembersListState extends GroupState {}
final class ClearGroupAdminsListState extends GroupState {}
final class CreateGroupSuccessState extends GroupState {}
final class CreateGroupErrorState extends GroupState {}
final class CreateGroupLoadingState extends GroupState {}
final class GroupMembersListUpdateSuccessState extends GroupState {}
final class GroupAdminsListUpdateSuccessState extends GroupState {}
