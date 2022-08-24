part of 'conversations_bloc.dart';

enum RecentStatus { init, loading, loaded, error }

// ignore: must_be_immutable
class ConversationsState extends Equatable {
  String currentUser;
  List<RecentConversation> conversations;
  RecentStatus status;
  ConversationsState({
    required this.currentUser,
    required this.conversations,
    required this.status,
  });

  ConversationsState.init()
      : this(currentUser: "", conversations: [], status: RecentStatus.init);

  ConversationsState.loaded(
    String currentUser,
    List<RecentConversation> conversations,
  ) : this(
            currentUser: currentUser,
            conversations: conversations,
            status: RecentStatus.loaded);

  ConversationsState.loading()
      : this(currentUser: "", conversations: [], status: RecentStatus.loading);

  ConversationsState.error()
      : this(currentUser: "", conversations: [], status: RecentStatus.error);

  @override
  List<Object> get props => [currentUser, conversations, status];
}
