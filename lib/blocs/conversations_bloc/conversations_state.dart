part of 'conversations_bloc.dart';


class ConversationsState extends Equatable {
  final String currentUser;
  final List<RecentConversation> conversations;
  final CustomStatus status;
 const  ConversationsState({
    required this.currentUser,
    required this.conversations,
    required this.status,
  });

  ConversationsState.init()
      : this(currentUser: "", conversations: [], status: CustomStatus.init);

  const ConversationsState.loaded(
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
