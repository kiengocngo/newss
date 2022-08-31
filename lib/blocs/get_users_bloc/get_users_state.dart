part of 'get_users_bloc.dart';

enum GetStatus { init, success, error }

class GetUserState extends Equatable {
  final MyUser user;
  final GetStatus getStatus;
  final String message;
  const GetUserState(
      {required this.user, required this.getStatus, required this.message});
  GetUserState.init()
      : this(
            user: MyUser.defaultUser(),
            getStatus: GetStatus.init,
            message: "init");
  const GetUserState.success(MyUser myUser)
      : this(user: myUser, getStatus: GetStatus.success, message: "Success");
  GetUserState.error(String message)
      : this(
            user: MyUser.defaultUser(),
            getStatus: GetStatus.error,
            message: message);
  @override
  List<Object> get props => [user, getStatus];
}
