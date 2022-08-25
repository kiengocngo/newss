part of 'conversations_bloc.dart';

abstract class ConversationsEvent extends Equatable {
  const ConversationsEvent();

  @override
  List<Object> get props => [];
}

class ConversationSubmit extends ConversationsEvent {
  final String currentUser;
  const ConversationSubmit({required this.currentUser});

  @override
  List<Object> get props => [currentUser];
}

class ConversationsAddNewMessage extends ConversationsEvent {
  final RecentConversation recentConversation;

  const ConversationsAddNewMessage({
   required this.recentConversation,
  });

  @override
  List<Object> get props => [
        recentConversation,
      ];
}
