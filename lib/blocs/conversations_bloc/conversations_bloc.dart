// ignore: depend_on_referenced_packages, unused_import
import 'dart:async';

// ignore: depend_on_referenced_packages
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
      transformer: concurrent(),
    );
  }

  _onConversationsAddNewMessage(ConversationsAddNewMessage event,
      Emitter<ConversationsState> emit) async {
    var data = await service.getConversations(
        event.recentConversation.senderId, event.recentConversation.receiverId);
    List<QueryDocumentSnapshot<Map<String, dynamic>>> tmp = [];
    for (var element in data.docs) {
      if ([
        event.recentConversation.senderId,
        event.recentConversation.receiverId
      ].contains(element.data()["receiverId"])) {
        tmp.add(element);
      }
    }

    if (tmp.isEmpty) {
      service.addNewConversations(event.recentConversation);
    } else {
      service.fixConversation(tmp[0].id, event.recentConversation.message);
    }
    state.conversations.add(event.recentConversation);
    emit(ConversationsState.loaded(
        event.recentConversation.senderId, state.conversations));
  }

  _onConversationSubmit(
      ConversationSubmit event, Emitter<ConversationsState> emit) async {
    await emit.onEach<QuerySnapshot<Map<String, dynamic>>>(
        FireStoreResponse().getConversations(event.currentUser),
        onData: (data) {
      List<RecentConversation> tmp = [];
      for (var element in data.docs) {
        if (element.data()['senderId'] == event.currentUser ||
            element.data()['receiverId'] == event.currentUser) {
          tmp.add(RecentConversation.fromJson(element.data()));
        }
      }
      emit(ConversationsState.loaded(event.currentUser, tmp));
    });
  }
}
