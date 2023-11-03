import 'package:circular_chart_flutter/circular_chart_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashBoard_View extends StatefulWidget {
  const DashBoard_View({super.key});

  @override
  State<DashBoard_View> createState() => _DashBoard_ViewState();
}

class _DashBoard_ViewState extends State<DashBoard_View> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children:[
            Flexible(
              child:
                Container(
                  height: Get.height * .23,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (BuildContext context, int index) =>
                              Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Container(
                              padding: EdgeInsets.all(Get.height * .03),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: Get.height * .02,
                                  ),
                                  Row(
                                    children: [
                                      Text("Total Employees",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Get.height * .05,
                                  ),
                                  Row(
                                    children: [
                                      Text("353",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),),
                                      SizedBox(width: Get.width * .01,),
                                      Icon(Icons.arrow_upward,
                                      color: Colors.green,),
                                      Text("+15%",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.green
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: Column(
                    children: [
                      SizedBox(height: Get.height * .02,),
                      Text("Working Formate",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AnimatedCircularChart(
                              size: Size(120.0, 120.0),
                              initialChartData: <CircularStackEntry>[
                                CircularStackEntry(
                                  <CircularSegmentEntry>[
                                    CircularSegmentEntry(
                                      75,
                                      Colors.orange,
                                      rankKey: 'completed',
                                    ),
                                    CircularSegmentEntry(
                                      25,
                                      Colors.redAccent,
                                      rankKey: 'remaining',
                                    ),
                                  ],
                                  rankKey: 'progress',
                                ),
                              ],
                              chartType: CircularChartType.Radial,
                              percentageValues: true,
                              holeLabel: '328',
                              labelStyle:  TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.orange,
                              borderRadius: BorderRadius.circular(50)
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),

    );
  }
}
