import 'package:bloc/bloc.dart';
import 'package:news_app/blocs/sign_up_bloc/sign_up_event.dart';
import 'package:news_app/blocs/sign_up_bloc/sign_up_state.dart';
import 'package:news_app/services/firebase_auth_services.dart';
import 'package:news_app/src/models/auth_response.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final FirebaseAuthServices _authServices = FirebaseAuthServices();
  SignUpBloc() : super(const SignUpState.init()) {
    on<SignUpSubmitEvent>((event, emit) async {
      emit(const SignUpState.loading());
      if (event.password != event.reEnterPassword) {
        emit(const SignUpState.error(
            "your password and re enter are not the same. Please correct!"));
        return;
      }
      SignUpResponse result =
          await _authServices.signUp(event.email, event.password);
      if (result.isSuccess == true) {
        emit(SignUpState.loaded(result.uid));
      } else {
        emit(SignUpState.error(result.uid));
      }
    });
  }
}
