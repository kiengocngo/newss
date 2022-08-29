part of 'update_users_bloc.dart';

abstract class UpdateUsersState extends Equatable {
  const UpdateUsersState();

  @override
  List<Object> get props => [];
}

class UpdateUsersInitial extends UpdateUsersState {}

class UpdateUsersSuccess extends UpdateUsersState {
  final String message;
  const UpdateUsersSuccess({required this.message});
}

class UpdateUsersErrors extends UpdateUsersState {
  final String message;
  const UpdateUsersErrors({required this.message});
}
