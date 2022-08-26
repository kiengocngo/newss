part of 'change_password_bloc.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordSuccess extends ChangePasswordState {
  final String message;
  const ChangePasswordSuccess({required this.message});
  @override
  List<Object> get props => [message];
}
class ChangePasswordError extends ChangePasswordState {
  final String message;
  const ChangePasswordError({required this.message});
  @override
  List<Object> get props => [message];
}
