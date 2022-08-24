part of 'friend_request_bloc.dart';

enum FriendState { noRequest, firstRequest, seccondRequest, accept, error }

// ignore: must_be_immutable
class FriendRequestState extends Equatable {
  FriendState status;
  FriendRequestState({
    required this.status,
  });
  FriendRequestState.init() : this(status: FriendState.noRequest);
  FriendRequestState.error() : this(status: FriendState.error);
  FriendRequestState.noRequest() : this(status: FriendState.noRequest);
  FriendRequestState.firstRequest() : this(status: FriendState.firstRequest);
  FriendRequestState.secondRequest() : this(status: FriendState.seccondRequest);
  FriendRequestState.accept() : this(status: FriendState.accept);
  @override
  List<Object> get props => [status];
}
