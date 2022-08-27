part of 'friend_request_bloc.dart';

class FriendRequestEvent extends Equatable {
  const FriendRequestEvent();

  @override
  List<Object> get props => [];
}

class FriendRequestEventSubmit extends FriendRequestEvent {
  final String currentUserUid;
  final String targetUserUid;
  const FriendRequestEventSubmit({
    required this.currentUserUid,
    required this.targetUserUid,
  });
  @override
  List<Object> get props => [currentUserUid, targetUserUid];
}

class FriendRequestEventInit extends FriendRequestEvent {
  final String currentUserUid;
  final String targetUserUid;
  const FriendRequestEventInit({
    required this.currentUserUid,
    required this.targetUserUid,
  });
  @override
  List<Object> get props => [currentUserUid, targetUserUid];
}
