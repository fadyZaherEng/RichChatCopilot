import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:rich_chat_copilot/lib/src/core/utils/constants.dart';
import 'package:rich_chat_copilot/lib/src/data/source/local/single_ton/firebase_single_ton.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/login/user.dart';

part 'chats_event.dart';

part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  ChatsBloc() : super(ChatsInitial()) {
    on<GetAllUsersEvent>(_onGetAllUsersEvent);
    on<GetCurrentUserEvent>(_onGetCurrentUserEvent);
  }

  // FirebaseFirestore _firestore = FirebaseSingleTon.db;

  FutureOr<void> _onGetAllUsersEvent(
      GetAllUsersEvent event, Emitter<ChatsState> emit) async {
    emit(GetUserChatsLoading());
    try {
      List<UserModel> users = [];
      await FirebaseSingleTon.db
          .collection("users")
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          users.add(UserModel.fromJson(doc.data() as Map<String, dynamic>));
        }
      });
      emit(GetUserChatsSuccess(users: users));
    } catch (e) {
      emit(GetUserChatsError(message: e.toString()));
    }
  }

  FutureOr<void> _onGetCurrentUserEvent(
      GetCurrentUserEvent event, Emitter<ChatsState> emit) async {
    emit(GetCurrentUserChatsLoading());
    try {
      UserModel user=UserModel();
    DocumentSnapshot doc = await FirebaseSingleTon.db
          .collection(Constants.users)
          .doc(event.uid)
          .get();
      user=UserModel.fromJson(doc.data() as Map<String, dynamic>);
      emit(GetCurrentUserChatsSuccess(user: user));
    } catch (e) {
      emit(GetCurrentUserChatsError(message: e.toString()));
    }
  }
}
