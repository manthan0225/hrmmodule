import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hrmodules/HRM_module/hrm_Dashboard.dart';
import 'package:hrmodules/authentication/login_page.dart';
import 'package:hrmodules/services/auth_service.dart';
import 'package:hrmodules/services/register_services.dart';
import 'package:provider/provider.dart';

class Registration_page extends StatefulWidget {
  const Registration_page({super.key});

  @override
  State<Registration_page> createState() => _Registration_pageState();
}

class _Registration_pageState extends State<Registration_page> {


  void signUp() async {
    final authServices = Provider.of<AuthServices>(context, listen: false);

    // Get the text values from the input fields
    String name = namecontroller.text.toString();
    String email = emailcontroller.text.toString();
    String mobile = mobilecontroller.text.toString();
    String password = passwordcontroller.text.toString();

    // Regular expressions for email format validation
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    final passwordRegExp = RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}$');

    // Check if any of the fields are empty
    if (name.isEmpty || email.isEmpty || mobile.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please fill in all the fields."),
          backgroundColor: Colors.indigo,
        ),
      );
    } else if (!emailRegExp.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enter a valid email address."),
          backgroundColor: Colors.indigo,
        ),
      );
    } else if (mobile.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Mobile number should have exactly 10 digits."),
          backgroundColor: Colors.indigo,
        ),
      );
    } else if (!passwordRegExp.hasMatch(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please enter a valid password. It should be at least 6 characters long and contain at least one lowercase letter, one uppercase letter, and one digit.",
          ),
          backgroundColor: Colors.indigo,
        ),
      );
    } else {
      // Attempt to sign up with the provided data
      try {
        await authServices.signUpWithEmailandPassword(email, password);
        // You can add additional logic here to save user data or perform other actions upon successful registration.
        Get.to(HRM_Module());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.indigo,
          ),
        );
      }
    }
  }




  TextEditingController namecontroller = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();

  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();

  Register_Services register_services = Register_Services();

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
                      controller: emailcontroller,
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
                      keyboardType: TextInputType.number,
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
                      controller: passwordcontroller,
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
                      signUp();
                      register_services.resgidterData(
                          namecontroller.text.toString(),
                          emailcontroller.text.toString(),
                          passwordcontroller.text.toString(),
                          mobilecontroller.text.toString());
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
                      text: "Alredy have an account ?? ",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      children: [
                        WidgetSpan(
                          child: InkWell(
                            onTap: () {
                              Get.to(Login_Page());
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
