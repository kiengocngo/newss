import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUpEventInit extends SignUpEvent {
  @override
  List<Object?> get props => [];
}

class SignUpSubmitEvent extends SignUpEvent {
  final String email;
  final String password;
  final String reEnterPassword;

  SignUpSubmitEvent({
    required this.email,
    required this.password,
    required this.reEnterPassword,
  });
  @override
  List<Object?> get props => [email, password];
}
