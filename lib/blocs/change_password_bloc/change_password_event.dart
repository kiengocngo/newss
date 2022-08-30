part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class ChangePassword extends ChangePasswordEvent {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;
  const ChangePassword(
      {required this.currentPassword,
      required this.newPassword,
      required this.confirmPassword});
  @override
  List<Object> get props => [currentPassword, newPassword, confirmPassword];
}
