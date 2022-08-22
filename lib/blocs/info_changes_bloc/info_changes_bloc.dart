import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/services/firestore_services.dart';
import 'package:news_app/src/models/my_user.dart';
part 'info_changes_event.dart';
part 'info_changes_state.dart';

class InfoChangesBloc extends Bloc<InfoChangesEvent, InfoChangesState> {
  final FireStoreService _instance = FireStoreService();
  InfoChangesBloc() : super(InfoChangesState.init()) {
    on<InfoAddNewUserEvent>((event, emit) async {
      emit(InfoChangesState.loading());
      String status = await _instance.addNewUser(event.myUser);
      if (status == "Success") {
        emit(InfoChangesState.success(event.myUser));
      } else {
        emit(InfoChangesState.error());
      }
    });
  }
}
