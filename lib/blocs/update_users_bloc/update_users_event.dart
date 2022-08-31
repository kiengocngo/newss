part of 'update_users_bloc.dart';

abstract class UpdateUsersEvent extends Equatable {
  const UpdateUsersEvent();

  @override
  List<Object> get props => [];
}

class UpdateUsers extends UpdateUsersEvent {
  final String uid;
  final String name;
  final String address;
  final String phone;
  final String base64Image;

  const UpdateUsers(
      {required this.uid,
      required this.name,
      required this.address,
      required this.phone,
      required this.base64Image});
  @override
  List<Object> get props => [uid, name, address, phone, base64Image];
}
