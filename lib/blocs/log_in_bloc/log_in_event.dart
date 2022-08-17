part of 'log_in_bloc.dart';

abstract class LogInEvent extends Equatable {
  const LogInEvent();

  @override
  List<Object> get props => [];
}

class LogInEventInit extends LogInEvent {
  const LogInEventInit();
  @override
  List<Object> get props => [];
}

class LogInSubmitEvent extends LogInEvent {
  final String email;
  final String password;
  const LogInSubmitEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class LogInSignOutEvent extends LogInEvent {
  const LogInSignOutEvent();
  @override
  List<Object> get props => [];
}
