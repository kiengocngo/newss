part of 'friend_search_bloc.dart';

abstract class FriendSearchEvent extends Equatable {
  const FriendSearchEvent();
  @override
  List<Object> get props => [];
}

class FriendSearchInit extends FriendSearchEvent {
  const FriendSearchInit();
}

class FriendSearchSubmit extends FriendSearchEvent {
  final String name;
  const FriendSearchSubmit({
    required this.name,
  });
  @override
  List<Object> get props => [name];
}
