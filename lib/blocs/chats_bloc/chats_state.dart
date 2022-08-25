part of 'chats_bloc.dart';

// ignore: must_be_immutable
class ChatsState extends Equatable {
  CustomStatus chatStatus;
  List<Chat> chats;
  ChatsState({
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
  ChatsState.loaded(List<Chat> chats)
      : this(chatStatus: CustomStatus.loaded, chats: chats);
  @override
  List<Object> get props => [chatStatus, chats];
}
