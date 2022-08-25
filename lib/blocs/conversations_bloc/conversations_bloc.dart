// ignore: depend_on_referenced_packages
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/responses/firebase_responses/firestore_responses.dart';
import 'package:news_app/services/firebase_services/firestore_services.dart';
import 'package:news_app/src/components/constant.dart';
import 'package:news_app/src/models/recent_conversation.dart';

part 'conversations_event.dart';
part 'conversations_state.dart';

class ConversationsBloc extends Bloc<ConversationsEvent, ConversationsState> {
  FireStoreService service = FireStoreService();
  ConversationsBloc() : super(ConversationsState.init()) {
    on<ConversationsAddNewMessage>(
      _onConversationsAddNewMessage,
      transformer: concurrent(),
    );
    on<ConversationSubmit>(
      _onConversationSubmit,
    );
  }
  FutureOr<void> _onConversationSubmit(
      ConversationSubmit event, Emitter<ConversationsState> emit) async {
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
  }

  FutureOr<void> _onConversationsAddNewMessage(ConversationsAddNewMessage event,
      Emitter<ConversationsState> emit) async {
    var data = await service.getConversations(
        event.recentConversation.senderId, event.recentConversation.receiverId);
    List<QueryDocumentSnapshot<Map<String, dynamic>>> tmp = [];
    data.docs.forEach((element) {
      if ([
        event.recentConversation.senderId,
        event.recentConversation.receiverId
      ].contains(element.data()["receiverId"])) {
        tmp.add(element);
      }
    });

    if (tmp.isEmpty) {
      service.addNewConversations(event.recentConversation);
    } else {
      service.fixConversation(tmp[0].id, event.recentConversation.message);
    }
    state.conversations.add(event.recentConversation);
    emit(ConversationsState.loaded(
        event.recentConversation.senderId, state.conversations));
  }
}
