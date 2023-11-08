import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hrmodules/authentication/registration_page.dart';
import 'package:hrmodules/services/auth_service.dart';
import 'package:provider/provider.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({super.key});

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isHidden = true;

  void signin() async {
    final authServices = Provider.of<AuthServices>(context, listen: false);

    try {
      await authServices.signInWithEmailandPassword(
          emailController.text.toString(), passwordController.text.toString());
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
              flex: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    "https://miro.medium.com/v2/resize:fit:740/0*-Vyqq7BQ0GYbOGZW.jpg",
                    height: Get.height * 0.2,
                    width: Get.width * 0.2,
                  ),
                  SizedBox(
                    height: Get.height * 0.1,
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
                  SizedBox(
                    width: Get.width * 0.3,
                    child: TextField(
                      controller: passwordController,
                      obscureText: isHidden,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Password',
                          suffixIcon: InkWell(
                            onTap: () {
                              togglePasswordView();
                            },
                            child: const Icon(
                              FontAwesomeIcons.eyeSlash,
                              size: 15,
                            ),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "Forgot Password",
                        style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.1,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  InkWell(
                    onTap: () {
                      signin();
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.indigo,
                      ),
                      height: Get.height * 0.06,
                      width: Get.width * 0.3,
                      child: const Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Don't have an have an Account ? ",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      children: [
                        WidgetSpan(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Registration_page()),
                              );
                            },
                            child: Text(
                              "Create an account",
                              style: TextStyle(
                                color: Colors.indigo,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )

                ],
              )),
          Expanded(
            flex: 50,
            child: Image.network(
              "https://media.istockphoto.com/id/1327069166/photo/take-control-and-watch-your-company-grow.jpg?s=612x612&w=0&k=20&c=ymBoYdRZZgRfRp_pBZlTElDkRPv4bFPuqckZda-EmEw=",
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }

  void togglePasswordView() {
    setState(() {
      isHidden = !isHidden;
    });
  }
}
