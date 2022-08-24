import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/services/firebase_services/firestore_services.dart';
import 'package:news_app/src/models/my_user.dart';

part 'friend_request_event.dart';
part 'friend_request_state.dart';

class FriendRequestBloc extends Bloc<FriendRequestEvent, FriendRequestState> {
  FriendRequestBloc() : super(FriendRequestState.init()) {
    on<FriendRequestEvent>((event, emit) {});
    on<FriendRequestEventSubmit>((event, emit) async {
      MyUser firstUser = FireStoreService().getUserByUid(event.firstUid)[0];
      MyUser secondUser = FireStoreService().getUserByUid(event.secondUid)[0];
      if (!firstUser.friends.contains(event.secondUid) &&
          !secondUser.friends.contains(event.firstUid)) {
        emit(FriendRequestState.noRequest());
        firstUser.friends.add(event.secondUid);
        FireStoreService()
            .fixUserInfo(event.firstUid, "friends", firstUser.friends);
        emit(FriendRequestState.firstRequest());
      } else if (firstUser.friends.contains(event.secondUid) &&
          !secondUser.friends.contains(event.firstUid)) {
        emit(FriendRequestState.firstRequest());
      } else if (!firstUser.friends.contains(event.secondUid) &&
          secondUser.friends.contains(event.firstUid)) {
        emit(FriendRequestState.secondRequest());
        FireStoreService()
            .fixUserInfo(event.firstUid, "friends", firstUser.friends);
        emit(FriendRequestState.accept());
      }
    });
  }
}
