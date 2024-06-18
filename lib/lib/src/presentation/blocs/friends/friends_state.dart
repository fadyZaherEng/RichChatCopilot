part of 'friends_bloc.dart';

@immutable
sealed class FriendsState {}

final class FriendsInitial extends FriendsState {}

final class GetFriendsLoading extends FriendsState {}
final class GetFriendsSuccess extends FriendsState {
  final List<UserModel> friends;
  GetFriendsSuccess({required this.friends});
}

final class GetFriendsError extends FriendsState {
  final String error;
  GetFriendsError({required this.error});
}

