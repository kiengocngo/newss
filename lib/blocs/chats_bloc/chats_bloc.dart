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
  ChatsBloc() : super(ChatsState.init()) {
    on<ChatsEvent>((event, emit) {});
    on<ChatInitEvent>(
      (event, emit) async {
        await emit.onEach<QuerySnapshot<Map<String, dynamic>>>(
            FireStoreResponse().getChats(event.senderId, event.receiverId),
            onData: ((data) {
          List<Chat> tmp = [];
          for (int i = 0; i < data.docs.length; i++) {
            if ([event.senderId, event.receiverId]
                .contains(data.docs[i].data()["receiverId"])) {
              tmp.add(Chat(
                  senderId: data.docs[i].data()["senderId"],
                  receiverId: data.docs[i].data()["receiverId"],
                  timeStamp: data.docs[i].data()["dateTime"],
                  message: data.docs[i].data()["message"]));
            }
          }
          emit(ChatsState.loaded(tmp));

          //  log(tmp.toString());
        }));
      },
      transformer: concurrent(),
    );

    on<ChatAddGetMessageEvent>(
      (event, emit) {
        fireStoreService.addNewChat(
            event.sender, event.receiver, event.message);
        state.chats.add(Chat(
            senderId: event.sender,
            receiverId: event.receiver,
            timeStamp: Timestamp.now(),
            message: event.message));

        emit(ChatsState.loaded(state.chats));
      },
    );
  }
}