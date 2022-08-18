part of 'chats_bloc.dart';

enum ChatStatus { init, loading, loaded, error }

// ignore: must_be_immutable
class ChatsState extends Equatable {
  ChatStatus chatStatus;
  List<Chat> chats;
  ChatsState({
    required this.chatStatus,
    required this.chats,
  });

  ChatsState.init()
      : this(
          chatStatus: ChatStatus.init,
          chats: [],
        );

  ChatsState.loading()
      : this(
          chatStatus: ChatStatus.loading,
          chats: [],
        );
        ChatsState.error()
      : this(
          chatStatus: ChatStatus.error,
          chats: [],
        );
  ChatsState.loaded(List<Chat> chats)
      : this(chatStatus: ChatStatus.loaded, chats: chats);
  @override
  List<Object> get props => [chatStatus, chats];
}
