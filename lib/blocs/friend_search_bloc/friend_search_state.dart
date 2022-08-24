part of 'friend_search_bloc.dart';

enum SearchStatus { init, loading, loaded, error }

// ignore: must_be_immutable
class FriendSearchState extends Equatable {
  SearchStatus searchStatus;
  List<MyUser> users;
  FriendSearchState({
    required this.searchStatus,
    required this.users,
  });

  FriendSearchState.init() : this(searchStatus: SearchStatus.init, users: []);
  FriendSearchState.loading()
      : this(searchStatus: SearchStatus.loading, users: []);
  FriendSearchState.loaded(List<MyUser> users)
      : this(searchStatus: SearchStatus.loaded, users: users);
  FriendSearchState.error() : this(searchStatus: SearchStatus.error, users: []);

  @override
  List<Object> get props => [searchStatus, users];
}
