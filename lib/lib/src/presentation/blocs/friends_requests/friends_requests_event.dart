part of 'friends_requests_bloc.dart';

@immutable
sealed class FriendsRequestsEvent {}

class GetFriendsRequestsEvent extends FriendsRequestsEvent {}
