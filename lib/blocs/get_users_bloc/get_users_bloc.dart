import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:news_app/services/users_services.dart';
import 'package:news_app/src/models/my_user.dart';
part 'get_users_event.dart';
part 'get_users_state.dart';

class GetUserBloc extends Bloc<GetUsersEvent, GetUserState> {
  final GetUserData _getUsersData = GetUserData();
  GetUserBloc() : super(GetUserState.init()) {
    on<GetUsers>(_onGetUsers);
  }
  void _onGetUsers(GetUsers event, Emitter<GetUserState> emit) async {
    try {
      var user = await _getUsersData.getUsersData(event.uid);
      emit(GetUserState.success(user));
    } on FirebaseException catch (e) {
      emit(GetUserState.error(e.code));
    } catch (e) {
      emit(GetUserState.error(e.toString()));
    }
  }
}
