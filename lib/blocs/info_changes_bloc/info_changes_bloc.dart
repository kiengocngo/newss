import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/services/firestore_services.dart';
import 'package:news_app/src/components/constant.dart';
import 'package:news_app/src/models/my_user.dart';

part 'info_changes_event.dart';
part 'info_changes_state.dart';

class InfoChangesBloc extends Bloc<InfoChangesEvent, InfoChangesState> {
  final FireStoreService _instance = FireStoreService();
  InfoChangesBloc() : super(InfoChangesState.init()) {
    on<InfoChangesEvent>((event, emit) {});
    on<InfoAddNewUserEvent>((event, emit) async {
      emit(InfoChangesState.loading());
      bool status = await _instance.addNewUser(
          event.uid,
          event.email,
          event.password,
          event.name,
          event.phoneNumber,
          event.address,
          event.base64Image);
      if (status == true) {
        emit(InfoChangesState.success(MyUser(
          uid: event.uid,
          name: event.name,
          password: event.password,
          email: event.email,
          address: event.address,
          base64Image: event.base64Image,
          phoneNumber: event.phoneNumber,
        )));
      } else {
        emit(InfoChangesState.error());
      }
    });
  }
}
