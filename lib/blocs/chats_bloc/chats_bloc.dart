import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/responses/firebase_responses/firestore_responses.dart';
import 'package:news_app/services/firebase_services/firestore_services.dart';
import 'package:news_app/src/models/chat.dart';

part 'chats_event.dart';
part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  FireStoreService fireStoreService = FireStoreService();
  var streamData = FireStoreResponse().getChats("1", "2");
  ChatsBloc() : super(ChatsState.init()) {
    on<ChatsEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ChatInitEvent>(
      (event, emit) async {
        await emit.onEach<QuerySnapshot<Map<String, dynamic>>>(streamData,
            onData: ((data) {
          List<Chat> tmp = [];
          for (int i = 0; i < data.docs.length; i++) {
            tmp.add(Chat(
                senderId: data.docs[i].data()["senderId"],
                receiverId: data.docs[i].data()["receiverId"],
                message: data.docs[i].data()["message"]));
          }
          state.chats = tmp;
          print(state.chats);
          emit(ChatsState.loaded(state.chats));
        }));
      },
      transformer: sequential(),
    );

    on<ChatAddGetMessageEvent>(
      (event, emit) {
        fireStoreService.addNewChat(
            event.sender, event.receiver, event.message);
        state.chats.add(Chat(
            senderId: event.sender,
            receiverId: event.receiver,
            message: event.message));
        emit(ChatsState.loaded(state.chats));
      },
    );
  }
}
