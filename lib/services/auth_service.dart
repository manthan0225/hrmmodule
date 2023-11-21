import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrmodules/authentication/login_page.dart';

class AuthServices extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> signInWithEmailandPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<UserCredential> signUpWithEmailandPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }


  void signOut() {
    _firebaseAuth.signOut();
    Get.to(Login_Page());
  }

  int forgotPassword(TextEditingController email,BuildContext context)
  {
    try
        {
          _firebaseAuth.sendPasswordResetEmail(email: email.text.toString());
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Reset Password"),
                backgroundColor: Colors.indigo),
          );

        }
       on FirebaseAuthException catch(e)
    {
      print(e);

    }
    return 1;

  }


}
