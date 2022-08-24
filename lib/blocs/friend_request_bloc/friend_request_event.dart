part of 'friend_request_bloc.dart';

class FriendRequestEvent extends Equatable {
  const FriendRequestEvent();

  @override
  List<Object> get props => [];
}

class FriendRequestEventSubmit extends FriendRequestEvent {
  final String firstUid;
  final String secondUid;
  const FriendRequestEventSubmit({
    required this.firstUid,
    required this.secondUid,
  });
  @override
  List<Object> get props => [firstUid, secondUid];
}

class FriendRequestEventInit extends FriendRequestEvent {
  final String firstUid;
  final String secondUid;
  const FriendRequestEventInit({
    required this.firstUid,
    required this.secondUid,
  });
  @override
  List<Object> get props => [firstUid, secondUid];
}
