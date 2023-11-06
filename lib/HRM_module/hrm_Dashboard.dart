import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrmodules/HRM_module/chat_viewpage.dart';
import 'package:hrmodules/HRM_module/dashBoard_View.dart';
import 'package:hrmodules/HRM_module/hrm_Tree.dart';

class HRM_Module extends StatefulWidget {
  const HRM_Module({Key? key}) : super(key: key);

  @override
  State<HRM_Module> createState() => _HRM_ModuleState();
}

class _HRM_ModuleState extends State<HRM_Module> {
  bool isDark = false;
  final List<String> item = [
    "Dashboard",
    "Team",
    "Tree",
    "Consultant",
    "Recruitment",
    "Reports",
    "Leaves",
  ];

  int selectedIdx = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.dialog(Chat_ViewPage());
                      },
                      icon: Icon(Icons.message, size: 25),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.notifications, size: 25),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: Get.height * 0.5,
                      child: SearchAnchor(
                        builder: (BuildContext context, SearchController controller) {
                          return SearchBar(
                            controller: controller,
                            onTap: () {
                              controller.openView();
                            },
                            onChanged: (_) {
                              controller.openView();
                            },
                            leading: const Icon(Icons.search, size: 25),
                            trailing: <Widget>[
                              Tooltip(
                                message: 'Change brightness mode',
                                child: IconButton(
                                  isSelected: isDark,
                                  onPressed: () {
                                    setState(() {
                                      isDark = !isDark;
                                    });
                                  },
                                  icon: const Icon(Icons.wb_sunny_outlined, size: 25),
                                  selectedIcon: const Icon(
                                    Icons.brightness_2_outlined,
                                    size: 25,
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                        suggestionsBuilder: (BuildContext context, SearchController controller) {
                          return List<ListTile>.generate(5, (int index) {
                            final String item = 'item $index';
                            return ListTile(
                              title: Text(item),
                              onTap: () {
                                setState(() {
                                  controller.closeView(item);
                                });
                              },
                            );
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: item.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectedIdx = index;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 13, vertical: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: selectedIdx == index
                                        ? Colors.black54
                                        : Colors.deepOrangeAccent.shade100,
                                  ),
                                  child: Text(
                                    "${item[index]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: selectedIdx == index ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Flexible(
              flex: 8,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
                child: pageRoute(selectedIdx),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget pageRoute(int selectedIndex) {
    switch (selectedIndex) {
      case 1:
        return DashBoard_View();
      case 2:
        return TreeViewPage();
      default:
        return DashBoard_View();
    }
  }
  PageRouteBuilder buildFadeRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

}


