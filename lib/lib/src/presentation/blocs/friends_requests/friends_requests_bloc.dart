import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:rich_chat_copilot/lib/src/core/utils/constants.dart';
import 'package:rich_chat_copilot/lib/src/data/source/local/single_ton/firebase_single_ton.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/login/user.dart';

part 'friends_requests_event.dart';

part 'friends_requests_state.dart';

class FriendsRequestsBloc
    extends Bloc<FriendsRequestsEvent, FriendsRequestsState> {
  FriendsRequestsBloc() : super(FriendsRequestsInitial()) {
    on<GetFriendsRequestsEvent>(_onGetFriendsRequestsEvent);
    on<AcceptFriendRequestEvent>(_onAcceptFriendRequestEvent);
  }

  FutureOr<void> _onGetFriendsRequestsEvent(
      GetFriendsRequestsEvent event, Emitter<FriendsRequestsState> emit) async {
    emit(GetFriendsRequestsLoading());
    try {
      String currentUserId = FirebaseSingleTon.auth.currentUser!.uid;
      //get all friends of current user from firebase
      DocumentSnapshot documentSnapshot = await FirebaseSingleTon.db
          .collection(Constants.users)
          .doc(currentUserId)
          .get();
      List<dynamic> friendUIds = documentSnapshot.get("friendsRequestsUIds");

      List<UserModel> friendsRequests = [];
      for (String friendUId in friendUIds) {
        DocumentSnapshot documentSnapshot = await FirebaseSingleTon.db
            .collection(Constants.users)
            .doc(friendUId)
            .get();
        UserModel friend =
            UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
        friendsRequests.add(friend);
      }
      emit(GetFriendsRequestsSuccess(friendsRequests: friendsRequests));
    } catch (e) {
      emit(GetFriendsRequestsError(message: e.toString()));
    }
  }

  FutureOr<void> _onAcceptFriendRequestEvent(
      AcceptFriendRequestEvent event, Emitter<FriendsRequestsState> emit) async{
    emit(AcceptFriendRequestsLoading());
    try {
      //TODO: implement accept friend request
      await FirebaseSingleTon.db
          .collection(Constants.users)
          .doc(event.friendId)
          .update({
        "friendsUIds":
        FieldValue.arrayUnion([FirebaseSingleTon.auth.currentUser!.uid]),
      });
      await FirebaseSingleTon.db
          .collection(Constants.users)
          .doc(FirebaseSingleTon.auth.currentUser!.uid)
          .update({
        "friendsUIds": FieldValue.arrayUnion([event.friendId]),
      });
      await FirebaseSingleTon.db
          .collection(Constants.users)
          .doc(event.friendId)
          .update({
        "sendFriendRequestsUIds":
        FieldValue.arrayRemove([FirebaseSingleTon.auth.currentUser!.uid]),
      });
      await FirebaseSingleTon.db
          .collection(Constants.users)
          .doc(FirebaseSingleTon.auth.currentUser!.uid)
          .update({
        "friendsRequestsUIds": FieldValue.arrayRemove([event.friendId]),
      });
      emit(AcceptFriendRequestsSuccess());
    } catch (e) {
      print(e);
      emit(AcceptFriendRequestsError(message: e.toString()));
    }
  }
}
