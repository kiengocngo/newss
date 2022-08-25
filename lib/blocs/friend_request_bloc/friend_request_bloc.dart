import 'dart:async';

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
    on<FriendRequestEventSubmit>(_onFriendRequestSubmit);
  }

  _onFriendRequestSubmit(
      FriendRequestEventSubmit event, Emitter<FriendRequestState> emit) async {
    SearchResponse firstUser =
        await FireStoreService().getUserByUid(event.firstUid);
    SearchResponse secondUser =
        await FireStoreService().getUserByUid(event.secondUid);
    List<dynamic> firstUserList = firstUser.data[0].friends;
    List<dynamic> secondUserList = secondUser.data[0].friends;

    // ignore: unused_local_variable
    int friendsCase = (firstUserList.contains(event.secondUid) ? 1 : 0) +
        (secondUserList.contains(event.firstUid) ? 1 : 0);

    switch (friendsCase) {
      case 0:
        // no request
        emit(FriendRequestState.noRequest());
        firstUserList.add(event.secondUid);
        FireStoreService()
            .fixUserInfo(firstUser.data[0].uid, "friends", firstUserList);
        emit(FriendRequestState.firstRequest());
        break;
      case 1:
        //1 send request cho 2
        if (firstUserList.contains(event.secondUid)) {
          emit(FriendRequestState.firstRequest());
          break;
        } else {
          // 2 reuest doi 1 accept
          emit(FriendRequestState.secondRequest());
          firstUserList.add(event.secondUid);
          FireStoreService()
              .fixUserInfo(firstUser.data[0].uid, "friends", firstUserList);
          emit(FriendRequestState.accept());
          break;
        }
      default:
        emit(FriendRequestState.accept());
        break;
    }
  }

  FutureOr<void> _onFriendRequestInit(
      FriendRequestEventInit event, Emitter<FriendRequestState> emit) async {
    SearchResponse firstUser =
        await FireStoreService().getUserByUid(event.firstUid);
    SearchResponse secondUser =
        await FireStoreService().getUserByUid(event.secondUid);
    List<dynamic> firstUserList = firstUser.data[0].friends;
    List<dynamic> secondUserList = secondUser.data[0].friends;

    // ignore: unused_local_variable
    int friendsCase = (firstUserList.contains(event.secondUid) ? 1 : 0) +
        (secondUserList.contains(event.firstUid) ? 1 : 0);

    switch (friendsCase) {
      case 0:
        // no request
        emit(FriendRequestState.noRequest());
        break;
      case 1:
        //1 send request cho 2 hoac nguoc lai
        if (firstUserList.contains(event.secondUid)) {
          emit(FriendRequestState.firstRequest());
          break;
        } else {
          emit(FriendRequestState.secondRequest());
          break;
        }
      default:
        emit(FriendRequestState.accept());
        break;
    }
  }
}
