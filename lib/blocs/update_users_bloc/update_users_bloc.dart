import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/services/update_services.dart';
import 'package:news_app/src/models/auth_response.dart';
part 'update_users_event.dart';
part 'update_users_state.dart';

class UpdateUsersBloc extends Bloc<UpdateUsersEvent, UpdateUsersState> {
  final UpdateServices _updateServices = UpdateServices();
  UpdateUsersBloc() : super(UpdateUsersInitial()) {
    on<UpdateUsers>(_onUpdateUsers);
  }
  void _onUpdateUsers(UpdateUsers event, Emitter<UpdateUsersState> emit) async {
    UpdateResponse status = await _updateServices.updateUser(
        event.uid, event.name, event.phone, event.address, event.base64Image);
    if (status.isSuccess == true) {
      emit(UpdateUsersSuccess(message: status.message));
    } else {
      emit(UpdateUsersErrors(message: status.message));
    }
  }
}
