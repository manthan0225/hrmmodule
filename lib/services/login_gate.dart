import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hrmodules/HRM_module/hrm_Dashboard.dart';
import 'package:hrmodules/authentication/login_page.dart';

class Login_Auth extends StatefulWidget {
  const Login_Auth({Key? key}) : super(key: key);

  @override
  State<Login_Auth> createState() => _Login_AuthState();
}

class _Login_AuthState extends State<Login_Auth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HRM_Module();
            } else {
              return Login_Page();
            }
          }),
    );
  }
}
