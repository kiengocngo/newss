import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/services/change_password_services.dart';

import '../../src/models/my_user.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  final FirebaseAuth _user = FirebaseAuth.instance;
  final ChangePasswordServices _changePasswordServices =
      ChangePasswordServices();
  ChangePasswordBloc() : super(ChangePasswordInitial()) {
    on<ChangePassword>(_onChangePassword);
  }
  void _onChangePassword(
      ChangePassword event, Emitter<ChangePasswordState> emit) async {
    var data = await _instance
        .collection("Users")
        .where("uid", isEqualTo: _user.currentUser!.uid)
        .get();
    var usersData = MyUser.fromJson(data.docs[0].data());
    if (event.currentPassword == usersData.password) {
      if (event.newPassword == event.confirmPassword) {
        _changePasswordServices.changePassword(event.newPassword);
        emit(const ChangePasswordSuccess(message: 'Success'));
      } else {
        emit(const ChangePasswordError(
            message: 'New Pass and Confirm Pass is not matched'));
      }
    } else {
      emit(const ChangePasswordError(
          message: 'Current Password is wrong, please try again'));
    }
  }
}
