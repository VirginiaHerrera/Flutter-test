import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future createAcount(String name, String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      print(userCredential.user);
      return (userCredential.user?.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('Password provider is too weak');
        return 1;
      } else if (e.code == 'email-already-in-use') {
        print('Email is being using!');
        return 2;
      }
    } catch (e) {
      print(e);
    }
  }

  Future singInEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.singInEmailAndPassword(email: email, password: password);

      final a = userCredential.user;
      if (a?.uid != null) {
        return a?.uid;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 1;
      } else if (e.code == 'wrong-password') {
        return 2;
      }
    }
  }
}

extension on FirebaseAuth {
  singInEmailAndPassword({required String email, required String password}) {}
}
