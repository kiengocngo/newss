part of 'get_users_bloc.dart';

abstract class GetUsersEvent extends Equatable {
  const GetUsersEvent();

  @override
  List<Object> get props => [];
}

class GetUsers extends GetUsersEvent {
  final String uid;
  const GetUsers({required this.uid});
  @override
  List<Object> get props => [uid];
}
