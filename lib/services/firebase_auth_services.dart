import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/src/models/auth_response.dart';

class FirebaseAuthServices {
  final FirebaseAuth _instance = FirebaseAuth.instance;
  Future<String> signUp(String email, String password) async {
    try {
      await _instance.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return e.toString();
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
