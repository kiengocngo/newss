import 'dart:async';
import 'dart:developer';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/services/firebase_services/firestore_services.dart';
import 'package:news_app/src/models/auth_response.dart';

part 'friend_request_event.dart';
part 'friend_request_state.dart';

class FriendRequestBloc extends Bloc<FriendRequestEvent, FriendRequestState> {
  FriendRequestBloc() : super(FriendRequestState.init()) {
    on<FriendRequestEventInit>(_onFriendRequestInit);
    on<FriendRequestEventSubmit>((event, emit) async {
      SearchResponse firstUser =
          await FireStoreService().getUserByUid(event.firstUid);
      SearchResponse secondUser =
          await FireStoreService().getUserByUid(event.secondUid);
      log("1 ${firstUser.data[0].uid}  ${secondUser.data[0].uid}");
      if (!firstUser.data[0].friends.contains(event.secondUid) &&
          !secondUser.data[0].friends.contains(event.firstUid)) {
        emit(FriendRequestState.noRequest());
        firstUser.data[0].friends.add(event.secondUid);
        FireStoreService().fixUserInfo(
            firstUser.data[0].uid, "friends", firstUser.data[0].friends);
        emit(FriendRequestState.firstRequest());
      } else if (firstUser.data[0].friends.contains(event.secondUid) &&
          !secondUser.data[0].friends.contains(event.firstUid)) {
        emit(FriendRequestState.firstRequest());
      } else if (!firstUser.data[0].friends.contains(event.secondUid) &&
          secondUser.data[0].friends.contains(event.firstUid)) {
        emit(FriendRequestState.secondRequest());
        firstUser.data[0].friends.add(event.secondUid);
        FireStoreService().fixUserInfo(
            firstUser.data[0].uid, "friends", firstUser.data[0].friends);
        emit(FriendRequestState.accept());
      }
    });
  }

  FutureOr<void> _onFriendRequestInit(
      FriendRequestEventInit event, Emitter<FriendRequestState> emit) async {
    SearchResponse firstUser =
        await FireStoreService().getUserByUid(event.firstUid);
    SearchResponse secondUser =
        await FireStoreService().getUserByUid(event.secondUid);
   
    if (!firstUser.data[0].friends.contains(event.secondUid) &&
        !secondUser.data[0].friends.contains(event.firstUid)) {
      emit(FriendRequestState.noRequest());
    } else if (firstUser.data[0].friends.contains(event.secondUid) &&
        !secondUser.data[0].friends.contains(event.firstUid)) {
      emit(FriendRequestState.firstRequest());
    } else if (!firstUser.data[0].friends.contains(event.secondUid) &&
        secondUser.data[0].friends.contains(event.firstUid)) {
      emit(FriendRequestState.secondRequest());
    } else {
      emit(FriendRequestState.accept());
    }
  }
}
