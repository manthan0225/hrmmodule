import 'dart:js';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrmodules/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'services/login_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBDhpvD9RDWzwQCn2ZAFLEpKZLoslWGVsM",
      appId: "App id here",
      messagingSenderId: "Messaging sender id here",
      projectId: "project id here",
    ),
  );
  runApp(ChangeNotifierProvider(
    create: (context) => AuthServices(),
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login_Auth(),
      //HRM_Module(),
    );
  }
}
