import 'dart:async';


import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/services/firebase_services/firestore_services.dart';
import 'package:news_app/src/models/chats/auth_response.dart';

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
    SearchResponse firstUser =
        await FireStoreService().getUserByUid(event.firstUid);
    SearchResponse secondUser =
        await FireStoreService().getUserByUid(event.secondUid);
    if (firstUser.isSuccess && secondUser.isSuccess) {
      List<dynamic> firstUserList = firstUser.data.first.friends;
      List<dynamic> secondUserList = secondUser.data.first.friends;

      int firstCase = firstUserList.contains(event.secondUid) ? 1 : 0;
      int secondCase = secondUserList.contains(event.firstUid) ? 2 : 0;
      CustomCase friendsCase = CustomCase.values[firstCase | secondCase];
      switch (friendsCase) {
        case CustomCase.notRequest:
          // no request
          emit(const FriendRequestState.noRequest());
          firstUserList.add(event.secondUid);
          FireStoreService()
              .fixUserInfo(firstUser.data.first.uid, "friends", firstUserList);
          emit(const FriendRequestState.firstRequest());
          break;
        case CustomCase.request:
          //1 send request cho 2
          emit(const FriendRequestState.firstRequest());
          break;
        case CustomCase.acceptRequest:
          // 2 request doi 1 accept
          emit(const FriendRequestState.secondRequest());
          firstUserList.add(event.secondUid);
          FireStoreService()
              .fixUserInfo(firstUser.data.first.uid, "friends", firstUserList);
          emit(const FriendRequestState.accept());
          break;

        default:
          emit(const FriendRequestState.accept());
          break;
      }
    } else {
      emit(const FriendRequestState.noRequest());
    }
  }

  FutureOr<void> _onFriendRequestInit(
      FriendRequestEventInit event, Emitter<FriendRequestState> emit) async {
    SearchResponse firstUser =
        await FireStoreService().getUserByUid(event.firstUid);
    SearchResponse secondUser =
        await FireStoreService().getUserByUid(event.secondUid);
    if (firstUser.isSuccess && secondUser.isSuccess) {
      List<dynamic> firstUserList = firstUser.data.first.friends;
      List<dynamic> secondUserList = secondUser.data.first.friends;

      int firstCase = firstUserList.contains(event.secondUid) ? 1 : 0;
      int secondCase = secondUserList.contains(event.firstUid) ? 2 : 0;
      CustomCase friendsCase = CustomCase.values[firstCase | secondCase];

      switch (friendsCase) {
        case CustomCase.notRequest:
          // no request
          emit(const FriendRequestState.noRequest());
          break;
        case CustomCase.request:
          //1 send request cho 2 hoac nguoc lai

          emit(const FriendRequestState.firstRequest());
          break;
        case CustomCase.acceptRequest:
          emit(const FriendRequestState.secondRequest());
          break;

        default:
          emit(const FriendRequestState.accept());
          break;
      }
    } else {
      emit(const FriendRequestState.noRequest());
    }
  }
}
