import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:rich_chat_copilot/lib/src/core/utils/constants.dart';
import 'package:rich_chat_copilot/lib/src/data/source/local/single_ton/firebase_single_ton.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/login/user.dart';

part 'friends_event.dart';

part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  FriendsBloc() : super(FriendsInitial()) {
    on<GetFriends>(_onGetFriends);
  }

  FutureOr<void> _onGetFriends(
      GetFriends event, Emitter<FriendsState> emit) async {
    emit(GetFriendsLoading());
   try{
     String currentUserId = FirebaseSingleTon.auth.currentUser!.uid;
     //get all friends of current user from firebase
     DocumentSnapshot documentSnapshot = await FirebaseSingleTon.db
         .collection(Constants.users)
         .doc(currentUserId)
         .get();
     List<dynamic>friendUIds = documentSnapshot.get("friendsUIds");

     List<UserModel> friends = [];
     for (String friendUId in friendUIds) {
       DocumentSnapshot documentSnapshot = await FirebaseSingleTon.db
           .collection(Constants.users)
           .doc(friendUId)
           .get();
       UserModel friend = UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
       friends.add(friend);
     }
     emit(GetFriendsSuccess(friends: friends));
   }catch(e){
     emit(GetFriendsError(error: e.toString()));
   }
  }
}
