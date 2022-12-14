import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/services/firebase_auth_services.dart';
import 'package:news_app/src/models/auth_response.dart';
part 'log_in_event.dart';
part 'log_in_state.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  final FirebaseAuthServices _firebaseAuthServices = FirebaseAuthServices();
  LogInBloc() : super(LogInState.init()) {
    on<LogInSubmitEvent>((event, emit) async {
      emit(LogInState.loading());
      AuthResponse result =
          await _firebaseAuthServices.signIn(event.email, event.password);
      if (result.isSuccess) {
        emit(LogInState.loaded(result.data));
      } else {
        emit(LogInState.error(result.data));
      }
    });
    on<LogInSignOutEvent>((event, emit) {
      if (state.logInStatus == LogInStatus.loaded) {
        _firebaseAuthServices.signOut();
        emit(LogInState.init());
      }
    });
  }
}
