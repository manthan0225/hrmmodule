import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'hrmdata.dart';

class DashBoard_View extends StatefulWidget {
  const DashBoard_View({super.key});

  @override
  State<DashBoard_View> createState() => _DashBoard_ViewState();
}

class _DashBoard_ViewState extends State<DashBoard_View> {

  final data = [
    HRMData(name: "Total Employee", totaldigit: "353", rate: "1", per: "15"),
    HRMData(name: "Number of leaves", totaldigit: "24", rate: "2", per: "15"),
    HRMData(name: "New Employee", totaldigit: "27", rate: "1", per: "12"),
    HRMData(name: "Happiness rate", totaldigit: "80", rate: "2", per: "12"),
  ];

  final Dobdata = [
    DOBData(name: 'Manthan',date: "Today"),
    DOBData(name: 'Mansi',date: "Tomorrow"),
    DOBData(name: 'Rahul',date: "12-10-2002"),
    DOBData(name: 'Rajesh',date: "12-20-1997"),
  ];


  final leavedata = [
    LeaveData(name: 'Manthan',date: "Today",reas: "Sick"),
    LeaveData(name: 'Mansi',date: "Tomorrow",reas: "personal"),
    LeaveData(name: 'Rahul',date: "12-10-2002",reas: "Sick"),
    LeaveData(name: 'Rajesh',date: "12-20-1997",reas: "personal"),
  ];

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
                        itemCount: data.length,
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
                                      "${data[index].name}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Get.height * 0.03,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${data[index].totaldigit}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    SizedBox(width: Get.width * 0.01),
                                    data[index].rate == "1"
                                        ? Row(
                                          children: [
                                            Icon(
                                      Icons.arrow_upward,
                                      color: Colors.green,
                                    ),Text("+",
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 15
                                              ),)
                                          ],
                                        )
                                    :Row(
                                      children: [
                                        Icon(
                                          Icons.arrow_downward,
                                          color: Colors.red,
                                        ),
                                        Text("-",
                                        style: TextStyle(
                                            color: Colors.red,
                                          fontSize: 15
                                        ),)
                                      ],
                                    ),
                                    Text(
                                      "${data[index].per}%",
                                      style: data[index].rate == "1"
                                      ? TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.green,
                                      )
                                      :TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.red,
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
            Wrap(
              children:[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Get.height * 0.43,
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
                                  width: Get.width * .02,
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
                    ),
                    SizedBox(
                      height: Get.height * 0.43,
                      width: Get.width * 0.2,
                      child: Card(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0 ,vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("BirthDate",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15
                                        ),),
                                      Text("15-12-2023",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 13
                                          ))
                                    ],
                                  ),
                                  IconButton(onPressed: (){}, icon: Icon(Icons.more_vert_rounded))
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child:
                                    ListView.builder(
                                        itemCount: Dobdata.length,
                                        itemBuilder: (BuildContext context,index)
                                        {
                                          return  Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 3.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: Colors.deepOrangeAccent.shade100,
                                              ),
                                              child: ListTile(
                                                title: Text("${Dobdata[index].name}",
                                                    style: TextStyle(fontWeight: FontWeight.bold)),
                                                subtitle: Text("${Dobdata[index].date}"),
                                                leading: CircleAvatar(
                                                  radius: 20,
                                                  backgroundImage: NetworkImage("data:image/jpeg;base64,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",),
                                                ),
                                              ),
                                            ),
                                          );
                                        })
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.43,
                      width: Get.width * 0.2,
                      child: Card(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0 ,vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("HoliDay/Absent",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15
                                        ),),
                                      Text("15-12-2023",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 13
                                          ))
                                    ],
                                  ),
                                  IconButton(onPressed: (){}, icon: Icon(Icons.more_vert_rounded))
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child:
                                    ListView.builder(
                                        itemCount: leavedata.length,
                                        itemBuilder: (BuildContext context,index)
                                        {
                                          return  Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 3.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: Colors.deepOrangeAccent.shade100,
                                              ),
                                              child: ListTile(
                                                title: Text("${leavedata[index].name}",
                                                style: TextStyle(fontWeight: FontWeight.bold),),
                                                subtitle: Text("${leavedata[index].reas} - ${leavedata[index].date}"),
                                                leading: CircleAvatar(
                                                  radius: 20,
                                                  backgroundImage: NetworkImage("data:image/jpeg;base64,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",),
                                                ),
                                              ),
                                            ),
                                          );
                                        })
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ] ,
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
