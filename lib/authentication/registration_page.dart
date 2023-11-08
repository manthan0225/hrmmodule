import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hrmodules/HRM_module/dashBoard_View.dart';
import 'package:hrmodules/HRM_module/hrm_Dashboard.dart';
import 'package:hrmodules/authentication/login_page.dart';

class Registration_page extends StatefulWidget {
  const Registration_page({super.key});

  @override
  State<Registration_page> createState() => _Registration_pageState();
}

class _Registration_pageState extends State<Registration_page> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isHidden = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 50,
            child: Image.network(
              "https://media.istockphoto.com/id/1193287941/photo/business-colleagues-working-together-in-the-office.jpg?s=612x612&w=0&k=20&c=foSMYCMbrBehOUzBLWnyYcj3plBRGM2-rvj0UBUsVUE=",
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            flex: 50,
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    "https://miro.medium.com/v2/resize:fit:740/0*-Vyqq7BQ0GYbOGZW.jpg",
                    height: Get.height * 0.2,
                    width: Get.width * 0.2,
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Text("Register",
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
                    width: Get.width * 0.3,
                    child: TextField(
                      controller: namecontroller,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Full Name',
                          suffixIcon: Icon(
                            FontAwesomeIcons.person,
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
                      controller: mobilecontroller,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Mobile Number',
                          suffixIcon: Icon(
                            FontAwesomeIcons.mobile,
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
                  InkWell(
                    onTap: () {
                      Get.to(HRM_Module());

                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.indigo,
                      ),
                      height: Get.height * 0.06,
                      width: Get.width * 0.3,
                      child: const Center(
                        child: Text(
                          "Create Account",
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
                      text: "Alredy have an account ?  ? ",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      children: [
                        WidgetSpan(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Login_Page()),
                              );
                            },
                            child: Text(
                              "Login Now",
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
              )
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
