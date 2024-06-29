part of 'group_bloc.dart';

@immutable
sealed class GroupEvent {}
class ClearGroupEvent extends GroupEvent {}
