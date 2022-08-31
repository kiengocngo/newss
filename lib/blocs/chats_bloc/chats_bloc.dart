import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/responses/firebase_responses/firestore_responses.dart';
import 'package:news_app/services/firebase_services/firestore_services.dart';
import 'package:news_app/src/components/constant.dart';
import 'package:news_app/src/models/chats/chat.dart';
part 'chats_event.dart';
part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  FireStoreService fireStoreService = FireStoreService();
  ChatsBloc() : super(ChatsState.init()) {
    on<ChatInitEvent>(
      _onInitEvent,
      transformer: concurrent(),
    );
    on<ChatAddGetMessageEvent>(
      _onAddGetMessage,
    );
  }
  _onInitEvent(ChatInitEvent event, Emitter<ChatsState> emit) {
    emit.onEach<QuerySnapshot<Map<String, dynamic>>>(
        FireStoreResponse().getChats(event.senderId, event.receiverId),
        onData: ((data) {
      List<Chat> tmp = [];
      for (var element in data.docs) {
        if (event.senderId == element.data()["receiverId"] ||
            event.receiverId == element.data()["receiverId"]) {
          tmp.add(Chat.fromJson(element.data()));
        }
      }
      emit(ChatsState.loaded(tmp));
    }));
  }

  _onAddGetMessage(ChatAddGetMessageEvent event, Emitter<ChatsState> emit) {
    fireStoreService.addNewChat(
        event.chat.senderId, event.chat.receiverId, event.chat.message);
    state.chats.add(event.chat);

    emit(ChatsState.loaded(state.chats));
  }
}
