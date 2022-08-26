import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/services/firebase_services/firestore_services.dart';
import 'package:news_app/src/components/constant.dart';
import 'package:news_app/src/models/chats/auth_response.dart';
import 'package:news_app/src/models/chats/my_user.dart';

part 'friend_search_event.dart';
part 'friend_search_state.dart';

class FriendSearchBloc extends Bloc<FriendSearchEvent, FriendSearchState> {
  FriendSearchBloc() : super(FriendSearchState.init()) {
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
