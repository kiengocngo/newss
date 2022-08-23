import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/services/firebase_services/firestore_services.dart';
import 'package:news_app/src/models/auth_response.dart';
import 'package:news_app/src/models/my_user.dart';

part 'friend_search_event.dart';
part 'friend_search_state.dart';

class FriendSearchBloc extends Bloc<FriendSearchEvent, FriendSearchState> {
  FriendSearchBloc() : super(FriendSearchState.init()) {
    on<FriendSearchEvent>((event, emit) {});
    on<FriendSearchSubmit>((event, emit) async {
      emit(FriendSearchState.loading());
      SearchResponse searchResponse =
          await FireStoreService().getUserByName(event.name);
      if (searchResponse.isSuccess == true) {
        emit(FriendSearchState.loaded(searchResponse.data));
      } else {
        emit(FriendSearchState.error());
      }
    });
  }
}
