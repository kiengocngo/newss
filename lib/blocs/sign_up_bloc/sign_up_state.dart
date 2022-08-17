import 'package:equatable/equatable.dart';

enum SignUpStatus { init, loading, loaded, error }

// ignore: must_be_immutable
class SignUpState extends Equatable {
  SignUpStatus signUpStatus;
  String message;
  SignUpState({
    required this.signUpStatus,
    required this.message,
  });

  SignUpState.init()
      : this(
          signUpStatus: SignUpStatus.init,
          message: "init",
        );

  SignUpState.loading()
      : this(
          signUpStatus: SignUpStatus.loading,
          message: "loading",
        );

  SignUpState.loaded(message)
      : this(
          signUpStatus: SignUpStatus.loaded,
          message: message,
        );
  SignUpState.error(message)
      : this(
          signUpStatus: SignUpStatus.error,
          message: message,
        );
  @override
  List<Object?> get props => [signUpStatus, message];
}
