part of 'conversations_bloc.dart';

// ignore: must_be_immutable
class ConversationsState extends Equatable {
  String currentUser;
  List<RecentConversation> conversations;
  CustomStatus status;
  ConversationsState({
    required this.currentUser,
    required this.conversations,
    required this.status,
  });

  ConversationsState.init()
      : this(currentUser: "", conversations: [], status: CustomStatus.init);

  ConversationsState.loaded(
    String currentUser,
    List<RecentConversation> conversations,
  ) : this(
            currentUser: currentUser,
            conversations: conversations,
            status: CustomStatus.loaded);

  ConversationsState.loading()
      : this(currentUser: "", conversations: [], status: CustomStatus.loading);

  ConversationsState.error()
      : this(currentUser: "", conversations: [], status: CustomStatus.error);

  @override
  List<Object> get props => [currentUser, conversations, status];
}
