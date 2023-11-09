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
      projectId: "chatboard-85ecf",
      authDomain: "chatboard-85ecf.firebaseapp.com",
      databaseURL: "https://chatboard-85ecf-default-rtdb.firebaseio.com",
      storageBucket: "gs://chatboard-85ecf.appspot.com"
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
  void initState() {
    _initializeFirebase();
    super.initState();
  }

  _initializeFirebase() async {
    await Firebase.initializeApp();
  }


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login_Auth(),
      //HRM_Module(),
    );
  }
}

