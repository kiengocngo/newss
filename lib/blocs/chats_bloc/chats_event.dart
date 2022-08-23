part of 'chats_bloc.dart';

abstract class ChatsEvent extends Equatable {
  const ChatsEvent();

  @override
  List<Object> get props => [];
}

class ChatInitEvent extends ChatsEvent {
  final String senderId;
  final String receiverId;
  const ChatInitEvent({
    required this.senderId,
    required this.receiverId,
  });
  @override
  List<Object> get props => [senderId, receiverId];
}

// ignore: must_be_immutable
class ChatAddGetMessageEvent extends ChatsEvent {
  String sender;
  String receiver;
  String message;

  ChatAddGetMessageEvent({
    required this.sender,
    required this.receiver,
    required this.message,
  });
  @override
  List<Object> get props => [
        sender,
        receiver,
        message,
      ];
}
