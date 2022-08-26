part of 'chats_bloc.dart';

class ChatsState extends Equatable {
  final CustomStatus chatStatus;
  final List<Chat> chats;
  const ChatsState({
    required this.chatStatus,
    required this.chats,
  });

  ChatsState.init()
      : this(
          chatStatus: CustomStatus.init,
          chats: [],
        );

  ChatsState.loading()
      : this(
          chatStatus: CustomStatus.loading,
          chats: [],
        );
  ChatsState.error()
      : this(
          chatStatus: CustomStatus.error,
          chats: [],
        );
  const ChatsState.loaded(List<Chat> chats)
      : this(chatStatus: CustomStatus.loaded, chats: chats);
  @override
  List<Object> get props => [chatStatus, chats];
}
