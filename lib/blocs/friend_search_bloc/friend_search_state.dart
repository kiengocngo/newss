part of 'friend_search_bloc.dart';

class FriendSearchState extends Equatable {
  final CustomStatus searchStatus;
  final List<MyUser> users;
  const FriendSearchState({
    required this.searchStatus,
    required this.users,
  });

  FriendSearchState.init() : this(searchStatus: CustomStatus.init, users: []);
  FriendSearchState.loading()
      : this(searchStatus: CustomStatus.loading, users: []);
  const FriendSearchState.loaded(List<MyUser> users)
      : this(searchStatus: CustomStatus.loaded, users: users);
  FriendSearchState.error() : this(searchStatus: CustomStatus.error, users: []);

  @override
  List<Object> get props => [searchStatus, users];
}
