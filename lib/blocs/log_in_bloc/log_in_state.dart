part of 'log_in_bloc.dart';
enum LogInStatus { init, loading, loaded, error }

// ignore: must_be_immutable
class LogInState extends Equatable {
  // message chua uid cua user neu nhu log in thanh cong
  String message;
  LogInStatus logInStatus;
  LogInState({
    required this.message,
    required this.logInStatus,
  });

  LogInState.init() : this(logInStatus: LogInStatus.init, message: "init");
  LogInState.loading()
      : this(logInStatus: LogInStatus.loading, message: "loading");
  LogInState.loaded(String uid)
      : this(logInStatus: LogInStatus.loaded, message: uid);
  LogInState.error(String error)
      : this(logInStatus: LogInStatus.error, message: error);
  @override
  List<Object> get props => [message, logInStatus];
}
