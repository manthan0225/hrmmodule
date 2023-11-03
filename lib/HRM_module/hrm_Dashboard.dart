import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HRM_Module extends StatefulWidget {
  const HRM_Module({super.key});

  @override
  State<HRM_Module> createState() => _HRM_ModuleState();
}

class _HRM_ModuleState extends State<HRM_Module> {
  bool isDark = false;
  final List<String> item = [
    "Deshboard",
    "Team",
    "Tree",
    "Consultant",
    "Recruitment",
    "Reports",
    "Leaves",
  ];
  int selectedIdx = -1;

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
                      onPressed: () {},
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
                        builder:
                            (BuildContext context, SearchController controller) {
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
                                  icon: const Icon(Icons.wb_sunny_outlined,
                                      size: 25),
                                  selectedIcon: const Icon(
                                      Icons.brightness_2_outlined,
                                      size: 25),
                                ),
                              )
                            ],
                          );
                        },
                        suggestionsBuilder:
                            (BuildContext context, SearchController controller) {
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
                      return Row(
                        children: [
                          SizedBox(
                            width: Get.width * .05,
                          ),
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
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 13, vertical: 12),
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
                                        color: selectedIdx == index
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width * .05,
                          )
                        ],
                      );
                    }),
              ),
            ),
            Flexible(flex: 8, child: Text("cfhdecf")),
          ],
        ),
      ),
    );
  }
}
