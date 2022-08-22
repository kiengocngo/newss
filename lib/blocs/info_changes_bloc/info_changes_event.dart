part of 'info_changes_bloc.dart';

abstract class InfoChangesEvent extends Equatable {
  const InfoChangesEvent();
  @override
  List<Object> get props => [];
}

class InfoChangesInitEvent extends InfoChangesEvent {
  const InfoChangesInitEvent();
  @override
  List<Object> get props => [];
}

class InfoGetCurrentUser extends InfoChangesEvent {
  final String uid;
  const InfoGetCurrentUser({
    required this.uid,
  });
  @override
  List<Object> get props => [uid];
}

class InfoAddNewUserEvent extends InfoChangesEvent {
  // se doi thanh model User
  final MyUser myUser;
  const InfoAddNewUserEvent({
    required this.myUser,
  });

  @override
  List<Object> get props => [myUser];
}

class ChangeUserInfoEvent extends InfoChangesEvent {
  final String uid;
  final String field;
  final String data;
  const ChangeUserInfoEvent({
    required this.uid,
    required this.field,
    required this.data,
  });
  @override
  List<Object> get props => [uid, field, data];
}
