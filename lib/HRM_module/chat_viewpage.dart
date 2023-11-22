import 'dart:async';
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

  List userList = [];
  List<Message> messageList = [];

  String useremail = "";
  String userId = "";
  String receiverId = "";
  String sendername = "";
  String senderImg = "";
  String receivername = "";
  String receiverImg = "";

  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref("Users");
  String userIdIs = "";

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
                                  backgroundImage: NetworkImage(senderImg),
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
                                          senderImg =
                                              userList[index].profil_pic;

                                          return SizedBox.shrink();
                                        } else {
                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                receivername =
                                                    userList[index].name;
                                                receiverId = userList[index].id;
                                                receiverImg =
                                                    userList[index].profil_pic;
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
                                    backgroundImage: NetworkImage(receiverImg),
                                  ),
                                  title: Text("${receivername}"),
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 78,
                                child: messageList.length == 0 ||
                                        messageList.isEmpty
                                    ? Center(
                                        child: Text(
                                          "No Massage Available",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      )
                                    : ListView.builder(
                                        itemCount: messageList.length,
                                        itemBuilder: (context, index) {
                                          return Align(
                                              alignment: userId ==
                                                      messageList[index].sender
                                                  ? Alignment.topRight
                                                  : Alignment.topLeft,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors
                                                            .deepOrangeAccent
                                                            .shade100,
                                                        borderRadius: userId ==
                                                                messageList[index]
                                                                    .sender
                                                            ? BorderRadius.only(
                                                                bottomLeft:
                                                                    Radius.circular(
                                                                        20),
                                                                topLeft:
                                                                    Radius.circular(
                                                                        20),
                                                                topRight:
                                                                    Radius.circular(
                                                                        20))
                                                            : BorderRadius.only(
                                                                bottomRight:
                                                                    Radius.circular(20),
                                                                topLeft: Radius.circular(20),
                                                                topRight: Radius.circular(20))),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                          "${messageList[index].text}"),
                                                    )),
                                              ));
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
                                                contentPadding:
                                                    EdgeInsets.all(8.0),
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
                                          if (_typeAMessageController
                                                  .text.isEmpty ||
                                              _typeAMessageController.text
                                                      .toString() ==
                                                  "") {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text("Enter Some Msg"),
                                                backgroundColor: Colors.indigo,
                                              ),
                                            );
                                          } else {
                                            sendMessage(receiverId);
                                            getData(receiverId);
                                          }
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
      String text = _typeAMessageController.text;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      userId = prefs.getString('userId')!;

      String msgid = "${userId} ${rec}";

      FirebaseDatabase.instance
          .ref()
          .child('messages')
          .child("${msgid}")
          .push()
          .set({
        'text': text,
        'sender': userId,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
      _typeAMessageController.clear();
    }
  }

  void getData(String rec) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    messageList.clear();

    userId = prefs.getString('userId')!;

    String msgid = "${userId} ${rec}";

    String rmsgid = "${rec} ${userId}";

    DatabaseReference messagesRef =
        FirebaseDatabase.instance.ref('messages').child("${msgid}");

    DatabaseReference RmessagesRef =
        FirebaseDatabase.instance.ref('messages').child("${rmsgid}");

    messagesRef.printError(); // print error

    messagesRef.onValue.listen((event) {
      var snapshot = event.snapshot;

      if (snapshot.value != null) {
        Map<dynamic, dynamic>? messages =
            snapshot.value as Map<dynamic, dynamic>?;

        if (messages != null) {
          messages.forEach((key, value) {
            String text = value['text'];
            String sender = value['sender'];
            int timestamp = value['timestamp'];

            Message message = Message(
              text: text,
              sender: sender,
              timestamp: timestamp,
            );
            messageList.add(message);
          });
        }
      } else {
        print(" message list No messages found.");
      }
    });

    RmessagesRef.onValue.listen((event) {
      var snapshot = event.snapshot;

      if (snapshot.value != null) {
        Map<dynamic, dynamic>? messages =
            snapshot.value as Map<dynamic, dynamic>?;

        if (messages != null) {
          messages.forEach((key, value) {
            String text = value['text'];
            String sender = value['sender'];
            int timestamp = value['timestamp'];

            Message message = Message(
              text: text,
              sender: sender,
              timestamp: timestamp,
            );
            messageList.add(message);
          });
        }
        messageList.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      } else {
        print("No messages found.");
      }
    });
  }

  Future<List<UserModel>> loadUsersData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    useremail = prefs.getString('email') ?? '';

    Completer<List<UserModel>> completer = Completer();

    try {
      ref.onValue.listen((event) {
        final data = event.snapshot.value;
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
