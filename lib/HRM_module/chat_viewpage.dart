import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrmodules/HRM_module/hrmdata.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Chat_ViewPage extends StatefulWidget {
  const Chat_ViewPage({super.key});

  @override
  State<Chat_ViewPage> createState() => _Chat_ViewPageState();
}

class _Chat_ViewPageState extends State<Chat_ViewPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _typeAMessageController = TextEditingController();
  final chatname = [
    EmpName(
        name: "Mukesh Ambani",
        email: "mukesh123@gmail.com",
        isOnline: true,
        lastActive: DateTime.now(),
        image:
            "data:image/jpeg;base64,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",
        uid: '1'),
    EmpName(
        uid: '2',
        name: "Gautam Adani",
        email: "Gautam234@gmail.com",
        isOnline: true,
        lastActive: DateTime.now(),
        image:
            "data:image/jpeg;base64,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"),
  ];

  List userList = [];
  List<Message> messageList = [];

  String useremail = "";
  String userId = "";
  String receiverId = "";
  String sendername = "";
  String receivername = "";

  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref("Users");
  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                        flex: 25,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8)),
                                color: Colors.deepOrangeAccent.shade100,
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(chatname[0].image),
                                ),
                                title: Text("${sendername}"),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 7),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(),
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.search),
                                    hintText: 'Search',
                                    suffixIcon: Icon(Icons.close),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: FutureBuilder<List<UserModel>>(
                                future: loadUsersData(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    // If an error occurred
                                    return Center(
                                        child: Text('Error loading data'));
                                  } else {
                                    // If the data has been successfully loaded
                                    userList = snapshot.data ?? [];

                                    return ListView.builder(
                                      itemCount: userList.length,
                                      itemBuilder: (context, index) {
                                        bool shouldSkipItem = userList[index]
                                                .email ==
                                            useremail; // Replace 'John Doe' with the name you want to skip
                                        if (shouldSkipItem) {
                                          sendername = userList[index].name;
                                          return SizedBox.shrink();
                                        } else {
                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                receivername =
                                                    userList[index].name;
                                                receiverId = userList[index].id;

                                                print(
                                                    "Receiver id : ${receiverId}");
                                                getData(receiverId);
                                              });
                                            },
                                            child: ListTile(
                                              leading: Stack(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(
                                                            userList[index]
                                                                .profil_pic),
                                                  ),
                                                  Positioned(
                                                    bottom: 0,
                                                    right: 0,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 10),
                                                      child: CircleAvatar(
                                                        radius: 5,
                                                        backgroundColor:
                                                            // chatname[index]
                                                            //         .isOnline
                                                            //     ? Colors.green
                                                            //     :
                                                            Colors.grey,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              title: Text(
                                                  "${userList[index].name}"),
                                              subtitle: Text(
                                                  "${userList[index].email}"),
                                            ),
                                          );
                                        }
                                      },
                                    );
                                  }
                                },
                              ),
                            )
                          ],
                        )),
                    Container(
                      height: Get.height,
                      width: 2,
                      color: Colors.grey,
                    ),
                    Expanded(
                        flex: 75,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 11,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8)),
                                  color: Colors.deepOrangeAccent.shade100,
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(chatname[0].image),
                                  ),
                                  title: Text("${receivername}"),
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 78,
                                child: ListView.builder(
                                  itemCount: messageList.length,
                                    itemBuilder: (context, index) {
                                  return Text("${messageList[index].text}");
                                })),
                            Expanded(
                                flex: 11,
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0, vertical: 7),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(),
                                          ),
                                          child: Form(
                                            key: _formKey,
                                            child: TextFormField(
                                              controller:
                                                  _typeAMessageController,
                                              decoration: InputDecoration(
                                                prefixIcon: Icon(Icons.search),
                                                hintText: 'Type a message',
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    CircleAvatar(
                                      backgroundColor:
                                          Colors.deepOrangeAccent.shade100,
                                      child: IconButton(
                                        icon: Icon(Icons.send,
                                            color: Colors.black45),
                                        onPressed: () {
                                          sendMessage(receiverId);
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    CircleAvatar(
                                      backgroundColor:
                                          Colors.deepOrangeAccent.shade100,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.file_copy,
                                          color: Colors.black45,
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ))
                          ],
                        ))
                  ],
                ),
              ),
            ),
            Positioned(
                top: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.deepOrangeAccent.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.close),
                    color: Colors.white,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void sendMessage(String rec) async {
    if (_formKey.currentState!.validate()) {
      // Here, you can retrieve the text from the TextFormField
      String text = _typeAMessageController.text;

      // Clear the TextFormField
      _typeAMessageController.clear();

      SharedPreferences prefs = await SharedPreferences.getInstance();

      userId = prefs.getString('userId')!;
      // Save the message to the Realtime Database

      String msgid = "${userId} ${rec}";

      print("${msgid}");

      FirebaseDatabase.instance.ref().child('messages').child("${msgid}").push().set({
        'text': text,
        'sender': userId, // replace this with the actual username
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
    }
  }

  void getData(String rec) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId')!;
    String msgid = "${userId} ${rec}";

    DatabaseReference messagesRef = FirebaseDatabase.instance.ref().child('messages').child("${msgid}");

    messagesRef
        .once()
        .then((DataSnapshot snapshot) {
          if (snapshot.value != null) {
            Map<dynamic, dynamic>? messages =
                snapshot.value as Map<dynamic, dynamic>?;

            if (messages != null) {
              messageList.clear();
              messages.forEach((key, value) {
                String text = value['text'];
                String sender = value['sender'];
                int timestamp = value['timestamp'];

                Message message = Message(
                  text: text,
                  sender: sender,
                  timestamp: timestamp,
                );

                print(message);

                messageList.add(message);
              });
            }
          } else {
            print("No messages found.");
          }
        } as FutureOr Function(DatabaseEvent value))
        .catchError((error) {
      print("Error retrieving data: $error");
    });
  }

  Future<List<UserModel>> loadUsersData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    useremail = prefs.getString('email') ?? '';

    Completer<List<UserModel>> completer = Completer();

    try {
      ref.onValue.listen((event) {
        final data = event.snapshot.value;
        print(data);

        if (data != null) {
          List<UserModel> userList = [];
          for (var entry in (data as Map<String, dynamic>).entries) {
            var userData = entry.value;
            if (userData != null && userData['id'] != null) {
              userList.add(UserModel.fromJson(userData['id'], userData));
            } else {
              // Handle the case where 'id' or userData is null
              print('Invalid user data: $userData');
            }
          }

          // Complete the future with the userList
          completer.complete(userList);
        } else {
          // Handle the case where data is null
          completer.completeError(Exception('Data is null'));
        }
      });
    } catch (error) {
      print("Error retrieving data: $error");
      completer.completeError(error);
    }

    return completer.future;
  }
}
