part of 'conversations_bloc.dart';

abstract class ConversationsState extends Equatable {
  const ConversationsState();
  
  @override
  List<Object> get props => [];
}

class ConversationsInitial extends ConversationsState {}
