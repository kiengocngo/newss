import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/services/firebase_services/firestore_services.dart';
import 'package:news_app/src/models/chats/friends_models.dart';

part 'friend_request_event.dart';
part 'friend_request_state.dart';

enum CustomCase { notRequest, request, acceptRequest, accepted }

class FriendRequestBloc extends Bloc<FriendRequestEvent, FriendRequestState> {
  FriendRequestBloc() : super(const FriendRequestState.init()) {
    on<FriendRequestEventInit>(_onFriendRequestInit);
    on<FriendRequestEventSubmit>(_onFriendRequestSubmit);
  }

  _onFriendRequestSubmit(
      FriendRequestEventSubmit event, Emitter<FriendRequestState> emit) async {
    final QuerySnapshot<Map<String, dynamic>> data = await FireStoreService()
        .getFriends(event.currentUserUid, event.targetUserUid);
    if (data.docs.isEmpty) {
      emit(const FriendRequestState.noRequest());
      FireStoreService()
          .addFriendsRequest(event.currentUserUid, event.targetUserUid);
      emit(const FriendRequestState.firstRequest());
      return;
    } else {
      for (var element in data.docs) {
        if (element.data()["acceptUid"] == event.currentUserUid ||
            element.data()["acceptUid"] == event.targetUserUid) {
          FriendModel friendModel = FriendModel.fromJson(element.data());
          if (friendModel.status == true) {
            emit(const FriendRequestState.accept());
            return;
          } else {
            if (friendModel.requestUid == event.currentUserUid) {
              emit(const FriendRequestState.firstRequest());
              return;
            } else {
              emit(const FriendRequestState.secondRequest());
              FireStoreService().fixFriendRequest(element.id);
              return;
            }
            
          }
        }
      }
      emit(const FriendRequestState.noRequest());
      FireStoreService()
          .addFriendsRequest(event.currentUserUid, event.targetUserUid);
      emit(const FriendRequestState.firstRequest());
      return;
    }
  }

  _onFriendRequestInit(
      FriendRequestEventInit event, Emitter<FriendRequestState> emit) async {
    final QuerySnapshot<Map<String, dynamic>> data = await FireStoreService()
        .getFriends(event.currentUserUid, event.targetUserUid);
    if (data.docs.isEmpty) {
      emit(const FriendRequestState.noRequest());
      return;
    } else {
      for (var element in data.docs) {
        if (element.data()["acceptUid"] == event.currentUserUid ||
            element.data()["acceptUid"] == event.targetUserUid) {
          FriendModel friendModel = FriendModel.fromJson(element.data());
          if (friendModel.status == true) {
            emit(const FriendRequestState.accept());
            return;
          } else {
            if (friendModel.requestUid == event.currentUserUid) {
              emit(const FriendRequestState.firstRequest());
              return;
            } else {
              emit(const FriendRequestState.secondRequest());
              return;
            }
          }
        }
      }
    }
  }
}
