part of 'chats_bloc.dart';

abstract class ChatsEvent extends Equatable {
  const ChatsEvent();

  @override
  List<Object> get props => [];
}

class ChatInitEvent extends ChatsEvent {
  const ChatInitEvent();
  @override
  List<Object> get props => [];
}

class ChatAddGetMessageEvent extends ChatsEvent {
  String sender;
  String receiver;
  String message;
  DateTime timeStamp;
  ChatAddGetMessageEvent({
  required  this.sender ,
  required  this.receiver,
   required this.message ,
   required  this.timeStamp,
  });
    @override
  List<Object> get props => [sender,receiver,message,timeStamp];
}
