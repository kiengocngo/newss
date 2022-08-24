part of 'friend_request_bloc.dart';

abstract class FriendRequestEvent extends Equatable {
  const FriendRequestEvent();

  @override
  List<Object> get props => [];
}

class FriendRequestEventSubmit extends FriendRequestEvent {
  String firstUid;
  String secondUid;
  FriendRequestEventSubmit({
   required this.firstUid ,
   required this.secondUid ,
  });
    @override
  List<Object> get props => [firstUid,secondUid];
}
