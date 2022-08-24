part of 'friend_request_bloc.dart';

enum FriendState { noRequest, firstRequest, seccondRequest, accept }

class FriendRequestState extends Equatable {
  List<String> firstList;
  List<String> secondList;
  FriendState status;
  FriendRequestState({
    required this.firstList,
    required this.secondList,
    required this.status,
  });
  FriendRequestState.init()
      : this(firstList: [], secondList: [], status: FriendState.noRequest);

  @override
  List<Object> get props => [firstList, secondList, status];
}
