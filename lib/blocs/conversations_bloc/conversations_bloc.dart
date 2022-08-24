import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/responses/firebase_responses/firestore_responses.dart';
import 'package:news_app/services/firebase_services/firestore_services.dart';
import 'package:news_app/src/models/recent_conversation.dart';

part 'conversations_event.dart';
part 'conversations_state.dart';

class ConversationsBloc extends Bloc<ConversationsEvent, ConversationsState> {
  FireStoreService service = FireStoreService();
  ConversationsBloc() : super(ConversationsState.init()) {
    on<ConversationsEvent>((event, emit) {});
    on<ConversationsAddNewMessage>(
      (event, emit) async {
        var data =
            await service.getConversations(event.senderId, event.receiverId);
        List<QueryDocumentSnapshot<Map<String, dynamic>>> tmp = [];
        for (int i = 0; i < data.docs.length; i++) {
          if ([event.senderId, event.receiverId]
              .contains(data.docs[i].data()["receiverId"])) {
            tmp.add(data.docs[i]);
          }
        }
        if (tmp.isEmpty) {
          service.addNewConversations(
              event.senderId,
              event.receiverId,
              event.senderName,
              event.receiverName,
              event.senderImage,
              event.receiverImage,
              event.message,
              event.timestamp);
        } else {
          service.fixConversation(tmp[0].id, event.message);
        }
        state.conversations.add(RecentConversation(
            senderId: event.senderId,
            receiverId: event.receiverId,
            senderName: event.senderName,
            receiverName: event.receiverName,
            senderBase64Image: event.senderImage,
            receiverBase64Image: event.receiverImage,
            timeStamp: event.timestamp,
            message: event.message));
        emit(ConversationsState.loaded(event.senderId, state.conversations));
      },
    );
    on<ConversationSubmit>((event, emit) async {
      await emit.onEach<QuerySnapshot<Map<String, dynamic>>>(
        FireStoreResponse().getConversations(event.currentUser),
        onData: (data) {
          List<RecentConversation> tmp = [];
          for (int i = 0; i < data.docs.length; i++) {
            //add model from json
            if (data.docs[i].data()["senderId"] == event.currentUser ||
                data.docs[i].data()["receiverId"] == event.currentUser) {
              tmp.add(RecentConversation.fromJson(data.docs[i].data()));
            }
          }
          emit(ConversationsState.loaded(event.currentUser, tmp));
        },
      );
    });
  }
}
