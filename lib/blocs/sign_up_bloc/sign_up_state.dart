import 'package:equatable/equatable.dart';
enum SignUpStatus { init, loading, loaded, error }

class SignUpState extends Equatable {
  final SignUpStatus signUpStatus;
  final String message;
  const SignUpState({
    required this.signUpStatus,
    required this.message,
  });
  const SignUpState.init()
      : this(
          signUpStatus: SignUpStatus.init,
          message: "",
        );
  const SignUpState.loading()
      : this(
          signUpStatus: SignUpStatus.loading,
          message: "loading",
        );
  const SignUpState.loaded(message)
      : this(
          signUpStatus: SignUpStatus.loaded,
          message: message,
        );
  const SignUpState.error(message)
      : this(
          signUpStatus: SignUpStatus.error,
          message: message,
        );
  @override
  List<Object?> get props => [signUpStatus, message];
}
