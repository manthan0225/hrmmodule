import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
          children: [
            Flexible(
              child: Container(
                height: Get.height * 0.23,
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
                            padding: EdgeInsets.all(Get.height * 0.03),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: Get.height * 0.02,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Total Employees",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Get.height * 0.05,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "353",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    SizedBox(width: Get.width * 0.01),
                                    Icon(
                                      Icons.arrow_upward,
                                      color: Colors.green,
                                    ),
                                    Text(
                                      "+15%",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.green,
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
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.height * 0.4,
                  width: Get.width * 0.2,
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(height: Get.height * 0.02),
                        Text(
                          "Working Format",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            height: Get.height * 0.3,
                            width: Get.width * 0.3,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SfCircularChart(
                                  series: <DoughnutSeries<CircularChartModel,
                                      String>>[
                                    DoughnutSeries<CircularChartModel, String>(
                                      dataSource: <CircularChartModel>[
                                        CircularChartModel(
                                            'Completed', 75, Colors.orange),
                                        CircularChartModel(
                                            'Remaining', 25, Colors.redAccent),
                                      ],
                                      xValueMapper:
                                          (CircularChartModel data, _) =>
                                              data.segment,
                                      yValueMapper:
                                          (CircularChartModel data, _) =>
                                              data.value,
                                      pointColorMapper:
                                          (CircularChartModel data, _) =>
                                              data.color,
                                      dataLabelMapper:
                                          (CircularChartModel data, _) =>
                                              data.segment,
                                      innerRadius:
                                          '50%', // Set the inner radius to create a donut
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Total",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      "312",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Text("Remote"),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Text("On Site"),
                          ],
                        ),
                      ],
                    ),
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

class CircularChartModel {
  final String segment;
  final double value;
  final Color color;

  CircularChartModel(this.segment, this.value, this.color);
}
