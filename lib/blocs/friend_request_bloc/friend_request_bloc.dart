import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'friend_request_event.dart';
part 'friend_request_state.dart';

class FriendRequestBloc extends Bloc<FriendRequestEvent, FriendRequestState> {
  FriendRequestBloc() : super(FriendRequestInitial()) {
    on<FriendRequestEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
