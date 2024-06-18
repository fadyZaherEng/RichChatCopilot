part of 'friends_requests_bloc.dart';

@immutable
sealed class FriendsRequestsState {}

final class FriendsRequestsInitial extends FriendsRequestsState {}

final class GetFriendsRequestsLoading extends FriendsRequestsState {}

final class GetFriendsRequestsError extends FriendsRequestsState {
  final String message;

  GetFriendsRequestsError({required this.message});
}

final class GetFriendsRequestsSuccess extends FriendsRequestsState {
  final List<UserModel> friendsRequests;

  GetFriendsRequestsSuccess({required this.friendsRequests});
}
