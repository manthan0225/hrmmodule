import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hrmodules/authentication/login_page.dart';
import 'package:hrmodules/services/auth_service.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  AuthServices authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            "https://miro.medium.com/v2/resize:fit:740/0*-Vyqq7BQ0GYbOGZW.jpg",
            height: Get.height * 0.2,
            width: Get.width * 0.2,
          ),
          Text(
            "ForGot Password",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
          SizedBox(
            height: Get.height * 0.03,
          ),
          SizedBox(
            height: Get.height * 0.05,
          ),
          SizedBox(
            width: Get.width * 0.3,
            child: TextField(
              controller: emailController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email Address',
                  suffixIcon: Icon(
                    FontAwesomeIcons.envelope,
                    size: 17,
                  )),
            ),
          ),
          SizedBox(
            height: Get.height * 0.05,
          ),
          InkWell(
            onTap: () {
              setState(() {
                final email = emailController.text.toString();
                final result =  authServices.forgotPassword(email, context);
                if(result == 1)
                {
                  Get.to(Login_Page());
                }
              });
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.indigo,
              ),
              height: Get.height * 0.06,
              width: Get.width * 0.3,
              child: const Center(
                child: Text(
                  "Reset Password",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
