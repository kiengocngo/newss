part of 'conversations_bloc.dart';
enum RecentState{init,loading,loaded, error}
abstract class ConversationsState extends Equatable {
  const ConversationsState();
  
  @override
  List<Object> get props => [];
}

class ConversationsInitial extends ConversationsState {}
