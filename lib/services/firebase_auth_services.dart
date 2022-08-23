import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/src/models/auth_response.dart';

class FirebaseAuthServices {
  final FirebaseAuth _instance = FirebaseAuth.instance;
  Future<SignUpResponse> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return SignUpResponse(isSuccess: true, uid: userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      return SignUpResponse(isSuccess: false, uid: e.code);
    }
  }

  Future<AuthResponse> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _instance
          .signInWithEmailAndPassword(email: email, password: password);
      return AuthResponse(isSuccess: true, data: userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      return AuthResponse(isSuccess: false, data: e.code);
    } catch (e) {
      return AuthResponse(isSuccess: false, data: e.toString());
    }
  }

  signOut() async {
    await _instance.signOut();
  }
}
