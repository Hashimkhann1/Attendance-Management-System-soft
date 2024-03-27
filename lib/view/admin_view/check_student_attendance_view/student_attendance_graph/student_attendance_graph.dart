import 'package:attendancemanagementsystem/res/my_colors/my_colors.dart';
import 'package:attendancemanagementsystem/res/widgets/my_text.dart';
import 'package:attendancemanagementsystem/res/widgets/my_text_button.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StudenAttendanceGraph extends StatelessWidget {
  const StudenAttendanceGraph({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height * 0.26,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: MyColors.lightBlackColor,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                  children: [
                    MyText(title: "Total present",color: MyColors.whiteColor,fontSize: 17,fontWeight: FontWeight.bold,),
                    SizedBox(width: width * 0.02,),
                    MyText(title: "6",color: MyColors.whiteColor,fontSize: 19,fontWeight: FontWeight.bold,),
                  ],
                ),
                  Row(
                    children: [
                      MyText(title: "Total absent",color: MyColors.whiteColor,fontSize: 17,fontWeight: FontWeight.bold,),
                      SizedBox(width: width * 0.02,),
                      MyText(title: "2",color: MyColors.whiteColor,fontSize: 19,fontWeight: FontWeight.bold,),
                    ],
                  ),
                  Row(
                    children: [
                      MyText(title: "Total leave",color: MyColors.whiteColor,fontSize: 17,fontWeight: FontWeight.bold,),
                      SizedBox(width: width * 0.02,),
                      MyText(title: "2",color: MyColors.whiteColor,fontSize: 19,fontWeight: FontWeight.bold,),
                    ],
                  ),
                ],
              ),

              ////////// edit and add attendance button for admin ////////
              Column(
                children: [
                  MyTextButton(title: "Add attendance", fontWeight: FontWeight.bold, onPressed: (){},width: width * 0.32,height: height * 0.04, backgroundColor: MyColors.whiteColor,),
                  SizedBox(height: height * 0.01,),
                  MyTextButton(title: "Edit attendance", fontWeight: FontWeight.bold, onPressed: (){},width: width * 0.32,height: height * 0.04, backgroundColor: MyColors.whiteColor,),
                ],
              )
            ],
          ),

          /////////// chart code //////////
          Expanded(
            child: PieChart(
              PieChartData(
                sectionsSpace: 1,
                centerSpaceRadius: 0,
                sections: [

                  // Present chart data
                  PieChartSectionData(
                      value: 75.0,
                      color: Colors.green,
                      title: '90%',
                      titleStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                      radius: width * 0.20
                  ),

                  // Absent chart data
                  PieChartSectionData(
                      value: 10.0,
                      color: Colors.red,
                      title: '90%',
                      titleStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                      radius: width * 0.20
                  ),

                  // Leave chart data
                  PieChartSectionData(
                      value: 15.0,
                      color: Colors.yellow,
                      title: '90%',
                      titleStyle: TextStyle(color: MyColors.blackColor,fontWeight: FontWeight.bold),
                      radius: width * 0.20
                  ),
                ]
              )
            ),
          )
        ],
      ),
    );
  }
}
