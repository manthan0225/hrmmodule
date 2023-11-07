import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Notification_data extends StatefulWidget {
  const Notification_data({super.key});

  @override
  State<Notification_data> createState() => _Notification_dataState();
}

class _Notification_dataState extends State<Notification_data> {
  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder:
          (BuildContext context, MenuController controller, Widget? child) {
        return IconButton(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: Icon(Icons.notifications, size: 25),
        );
      },
      menuChildren: List<MenuItemButton>.generate(
        10,
        (int index) => MenuItemButton(
            onPressed: () {},
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.deepOrangeAccent.shade100,
                      child: Icon(
                        Icons.person,
                        color: Colors.black12,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Update Notification",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(" people may not remember your app"),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
              ],
            )),
      ),
    );
  }
}
