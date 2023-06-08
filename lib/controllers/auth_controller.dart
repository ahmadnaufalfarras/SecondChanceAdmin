import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUpUsers(
    String email,
    String password,
  ) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        await _firestore.collection('admin').doc(cred.user!.uid).set(
          {
            'email': email,
            'adminId': cred.user!.uid,
          },
        );
      } else {
        throw 'Please fields must not be empty';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'The password is too weak.';
      } else if (e.code == 'email-already-in-use') {
        throw 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        throw 'The email address is badly formatted';
      } else if (e.code == 'invalid-input') {
        throw 'Please fill all fields';
      } else {
        throw e.message ?? 'An error occurred while signing up';
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> loginUsers(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        bool isAdminUser = await _checkIfUserIsAdmin(email);
        if (isAdminUser) {
          await _auth.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
        } else {
          throw 'User is not authorized';
        }
      } else {
        throw 'Please fill in all fields';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw 'No user found';
      } else if (e.code == 'wrong-password') {
        throw 'Wrong password';
      } else {
        throw e.message ?? 'Something went wrong';
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> _checkIfUserIsAdmin(String email) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('admin')
          .where('email', isEqualTo: email)
          .get();

      return snapshot.docs.isNotEmpty;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> logoutUsers() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Error occurred while signing out: $e');
    }
  }
}
