part of 'info_changes_bloc.dart';
enum ChangesStage { init, loading, success, error }

// ignore: must_be_immutable
class InfoChangesState extends Equatable {
  ChangesStage changesStage;
  MyUser myUser;
  InfoChangesState({
    required this.changesStage,
    required this.myUser,
  });

  InfoChangesState.init()
      : this(changesStage: ChangesStage.init, myUser: MyUser.defaultUser());
  InfoChangesState.loading()
      : this(changesStage: ChangesStage.loading, myUser: MyUser.defaultUser());
  InfoChangesState.error()
      : this(changesStage: ChangesStage.error, myUser: MyUser.defaultUser());
  InfoChangesState.success(MyUser user)
      : this(changesStage: ChangesStage.success, myUser: user);
  @override
  List<Object> get props => [changesStage, myUser];
}
