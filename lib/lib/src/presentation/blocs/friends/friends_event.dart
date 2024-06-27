part of 'friends_bloc.dart';

@immutable
sealed class FriendsEvent {}

class GetFriends extends FriendsEvent {}
class GetFriendsRequestsEvent extends FriendsEvent {}
class AcceptFriendRequestEvent extends FriendsEvent {
  final String friendId;
  AcceptFriendRequestEvent({required this.friendId});
}
