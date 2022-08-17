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
  final String uid;
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  final String address;
  final String base64Image;
  const InfoAddNewUserEvent({
    required this.uid,
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.address,
    required this.base64Image,
  });

  @override
  List<Object> get props =>
      [uid, name, email, password, phoneNumber, address, base64Image];
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
