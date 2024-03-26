import 'package:attendancemanagementsystem/res/my_colors/my_colors.dart';
import 'package:attendancemanagementsystem/res/widgets/my_text.dart';
import 'package:attendancemanagementsystem/view/admin_view/check_student_attendance/student_attendance_graph/student_attendance_graph.dart';
import 'package:flutter/material.dart';

class CheckStudentAttendance extends StatelessWidget {
  const CheckStudentAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: MyColors.blackColor,
      appBar: AppBar(
        title: MyText(
          title: "Student attendance",
          color: MyColors.whiteColor,
          fontWeight: FontWeight.w500,
        ),
        iconTheme: IconThemeData(
          color: MyColors.whiteColor
        ),
        centerTitle: true,
        backgroundColor: MyColors.blackColor,
        shadowColor: MyColors.whiteColor,
        elevation: 14,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [

            SizedBox(height: height * 0.03,),

            ////////////////////////////////////////////////
            /////////// student attendance graph ///////////
            ////////////////////////////////////////////////
            StudenAttendanceGraph(),

            SizedBox(height: height * 0.01,),
            Expanded(
              child: ListView.builder(itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      width: width,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                      decoration: BoxDecoration(
                          color: MyColors.lightBlackColor,
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.delete,color: MyColors.whiteColor,),
                              SizedBox(width: width * 0.02,),
                              MyText(title: "1/2/2024",color: MyColors.whiteColor,fontWeight: FontWeight.bold,fontSize: 19,),
                            ],
                          ),
                          MyText(title: 'present',color: MyColors.whiteColor,fontWeight: FontWeight.bold,fontSize: 17,)
                        ],
                      ),
                    );
                  }
              ),
            )

          ],
        ),
      ),
    );
  }
}
