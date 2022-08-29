part of 'get_users_bloc.dart';

abstract class GetUsersState extends Equatable {
  const GetUsersState();

  @override
  List<Object> get props => [];
}

class GetUsersInitial extends GetUsersState {}

class GetUsersSuccess extends GetUsersState {
  final MyUser users;
  const GetUsersSuccess({required this.users});
  @override
  List<Object> get props => [users];
}

class GetUsersError extends GetUsersState {
  final String message;
  const GetUsersError({required this.message});
}
