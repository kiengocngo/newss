import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/src/models/chat.dart';

part 'chats_event.dart';
part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  ChatsBloc() : super(ChatsState.init()) {
    on<ChatsEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ChatInitEvent>((event, emit) {
      ChatsState.init();
      ChatsState.loading();
    });

    on<ChatAddGetMessageEvent>(
      (event, emit) {
        state.chats.add(Chat(
            senderId: event.sender,
            receiverId: event.receiver,
            dateTime: DateTime.now().toString(),
            message: event.message));
        emit(ChatsState.loaded(state.chats));
      },
    );
  }
}
