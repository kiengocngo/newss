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
  final String senderId;
  final String receiverId;
  final String senderName;
  final String receiverName;
  final String senderImage;
  final String receiverImage;
  final String message;
  final Timestamp timestamp;

  const ConversationsAddNewMessage({
    required this.senderId,
    required this.receiverId,
    required this.senderName,
    required this.receiverName,
    required this.senderImage,
    required this.receiverImage,
    required this.message,
    required this.timestamp,
  });

  @override
  List<Object> get props => [
        senderId,
        receiverId,
        senderName,
        receiverName,
        senderImage,
        receiverImage,
        message,
        timestamp,
      ];
}
