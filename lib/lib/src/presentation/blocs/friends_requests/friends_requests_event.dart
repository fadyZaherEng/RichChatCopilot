part of 'friends_requests_bloc.dart';

@immutable
sealed class FriendsRequestsEvent {}

class GetFriendsRequestsEvent extends FriendsRequestsEvent {}
class AcceptFriendRequestEvent extends FriendsRequestsEvent {
  final String friendId;
  AcceptFriendRequestEvent({required this.friendId});
}
