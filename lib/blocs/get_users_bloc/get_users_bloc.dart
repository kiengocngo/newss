import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:news_app/services/users_services.dart';
import 'package:news_app/src/models/my_user.dart';

part 'get_users_event.dart';
part 'get_users_state.dart';

class GetUsersBloc extends Bloc<GetUsersEvent, GetUsersState> {
  final GetUsersData _getUsersData = GetUsersData();
  GetUsersBloc() : super(GetUsersInitial()) {
    on<GetUsers>(_onGetUsers);
  }
  void _onGetUsers(GetUsers event, Emitter<GetUsersState> emit) async {
    try {
      var users = await _getUsersData.getUsersData(event.uid);
      emit(GetUsersSuccess(users: users));
    } on FirebaseException catch (e) {
      emit(GetUsersError(message: e.code));
    }
    catch(e)
    {
      emit(GetUsersError(message: e.toString()));
    }
  }
}
