import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hrmodules/authentication/login_page.dart';
import 'package:hrmodules/services/auth_service.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Registration_page extends StatefulWidget {
  const Registration_page({super.key});

  @override
  State<Registration_page> createState() => _Registration_pageState();
}

class _Registration_pageState extends State<Registration_page> {
  final datarefrence = FirebaseDatabase.instance.ref();
  String selectfile = '';
  late Uint8List selectedImageInBytes;
  String downloadURL = "";

  TextEditingController namecontroller = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();

  String name = "";
  String email = "";
  String mobile = "";
  String password = "";
  String pic = "";

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                imageprofile(),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Text(
                  "Register",
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
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    controller: mobilecontroller,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Mobile Number',
                        counterText: '',
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
                  onTap: () async {
                    if (namecontroller.text.isNotEmpty &&
                        emailcontroller.text.isNotEmpty &&
                        mobilecontroller.text.isNotEmpty &&
                        passwordcontroller.text.isNotEmpty &&
                        selectfile.isNotEmpty &&
                        selectedImageInBytes.isNotEmpty) {
                      await uploadFile();
                      await signUp();

                      namecontroller.clear();
                      emailcontroller.clear();
                      mobilecontroller.clear();
                      passwordcontroller.clear();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Please fill in all the fields."),
                          backgroundColor: Colors.indigo,
                        ),
                      );
                    }
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
                    text: "Already have an account ??",
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

  Widget imageprofile() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 80,
          backgroundImage: selectfile.isNotEmpty
              ? Image.memory(Uint8List.fromList(selectedImageInBytes)).image
              : AssetImage("assets/images/prof.png"),
        ),
        Positioned(
          bottom: 20,
          right: 10,
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Pick an image"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.photo_library),
                        title: Text("Pick from gallery"),
                        onTap: () {
                          Navigator.pop(context);
                          selectedFile(true);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.camera_alt),
                        title: Text("Take a photo"),
                        onTap: () {
                          Navigator.pop(context);
                          selectedFile(true);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
      ],
    );
  }

  void selectedFile(bool imageform) async {
    FilePickerResult? fileresult = await FilePicker.platform.pickFiles();

    if (fileresult != null) {
      setState(() {
        selectfile = fileresult.files.first.name;
        selectedImageInBytes = fileresult.files.first.bytes!;
      });
    }
  }

  uploadFile() async {
    try {
      firebase_storage.UploadTask uploadTask;

      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child("file")
          .child('/' + selectfile);

      final metadata =
          firebase_storage.SettableMetadata(contentType: 'image/jpeg');

      uploadTask = ref.putData(selectedImageInBytes, metadata);

      print(uploadTask);

      await uploadTask;

      downloadURL = await ref.getDownloadURL();

      print("File uploaded and download URL is: $downloadURL");
    } catch (e) {
      print(e);
    }
  }

  signUp() async {
    final authServices = Provider.of<AuthServices>(context, listen: false);

    name = namecontroller.text.toString();
    email = emailcontroller.text.toString();
    mobile = mobilecontroller.text.toString();
    password = passwordcontroller.text.toString();
    pic = downloadURL;

    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    final passwordRegExp = RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}$');

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
      try {
        if (pic.isNotEmpty) {
          final userData =
              await authServices.signUpWithEmailandPassword(email, password);

          final userId = userData.user!.uid;

          if (userId != "" &&
              name != "" &&
              email != "" &&
              mobile != "" &&
              pic != "") {
            datarefrence.child("Users").child(userId).set({
              'id': userId,
              'name': name,
              'email': email,
              // 'password': password,
              'mobile': mobile,
              'profil_pic': pic
            });
          }
          Get.to(Login_Page()); // Navigate to the login_page
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
