part of 'friend_search_bloc.dart';

// ignore: must_be_immutable
class FriendSearchState extends Equatable {
  CustomStatus searchStatus;
  List<MyUser> users;
  FriendSearchState({
    required this.searchStatus,
    required this.users,
  });

  FriendSearchState.init() : this(searchStatus: CustomStatus.init, users: []);
  FriendSearchState.loading()
      : this(searchStatus: CustomStatus.loading, users: []);
  FriendSearchState.loaded(List<MyUser> users)
      : this(searchStatus: CustomStatus.loaded, users: users);
  FriendSearchState.error() : this(searchStatus: CustomStatus.error, users: []);

  @override
  List<Object> get props => [searchStatus, users];
}
