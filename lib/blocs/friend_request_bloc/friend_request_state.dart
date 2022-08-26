part of 'friend_request_bloc.dart';

enum FriendState { noRequest, firstRequest, seccondRequest, accept, error }

class FriendRequestState extends Equatable {
  final FriendState status;
  const FriendRequestState({
    required this.status,
  });
  const FriendRequestState.init() : this(status: FriendState.noRequest);
  const FriendRequestState.error() : this(status: FriendState.error);
  const FriendRequestState.noRequest() : this(status: FriendState.noRequest);
  const FriendRequestState.firstRequest()
      : this(status: FriendState.firstRequest);
  const FriendRequestState.secondRequest()
      : this(status: FriendState.seccondRequest);
  const FriendRequestState.accept() : this(status: FriendState.accept);
  @override
  List<Object> get props => [status];
}
