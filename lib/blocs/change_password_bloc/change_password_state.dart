part of 'change_password_bloc.dart';
enum ChangePasswordStatus { init, success, error }

class ChangePasswordState extends Equatable {
  final String message;
  final ChangePasswordStatus status;
  const ChangePasswordState({required this.message, required this.status});

  const ChangePasswordState.init()
      : this(message: "init", status: ChangePasswordStatus.init);
  const ChangePasswordState.success(String message)
      : this(
          message: message,
          status: ChangePasswordStatus.success,
        );
  const ChangePasswordState.error(String message)
      : this(
          message: message,
          status: ChangePasswordStatus.error,
        );
  @override
  List<Object> get props => [message];
}
