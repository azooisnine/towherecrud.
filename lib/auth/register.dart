import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  static Future<String?> register({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // success
    } on FirebaseAuthException catch (e) {
      return e.code; // error code
    }
  }
}