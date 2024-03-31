import 'package:attendancemanagementsystem/res/my_colors/my_colors.dart';
import 'package:attendancemanagementsystem/res/widgets/my_text.dart';
import 'package:attendancemanagementsystem/res/widgets/my_text_button.dart';
import 'package:attendancemanagementsystem/view_model/attendance_view_model/attendance_view_model.dart';
import 'package:attendancemanagementsystem/view_model/getx/loading_getx/loading_getx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaveApprovalDetailView extends StatelessWidget {
  final String studentName;
  final String approvalStatus;
  final String approvalDate;
  final String approvalReadOrUnReadStatus;
  final String approvalId;

  LeaveApprovalDetailView(
      {super.key,
      required this.studentName,
      required this.approvalStatus,
      required this.approvalDate,
      required this.approvalReadOrUnReadStatus,
      required this.approvalId});

  final AttendanceViewModel attendanceViewModel = Get.put(AttendanceViewModel());
  final LoadingGetx loadingGetx = Get.put(LoadingGetx());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: MyColors.blackColor,
      appBar: AppBar(
        title: MyText(
          title: "Leave approval detail",
          color: MyColors.whiteColor,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        backgroundColor: MyColors.blackColor,
        shadowColor: MyColors.whiteColor,
        iconTheme: IconThemeData(color: MyColors.whiteColor),
        elevation: 14,
      ),
      body: Container(
        width: width,
        height: height * 0.56,
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.symmetric(vertical: height * 0.14, horizontal: 10),
        decoration: BoxDecoration(
            color: MyColors.lightBlackColor,
            borderRadius: BorderRadius.circular(14)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.02,
            ),
            ///// student name
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  title: studentName,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: MyColors.whiteColor,
                ),
                Icon(approvalReadOrUnReadStatus == 'read' ? Icons.mark_email_read : Icons.mark_email_unread_rounded,color: MyColors.lightgrayColor,size: 34,)
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            ///// approval status
            MyText(
              title: 'approavl status: $approvalStatus',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: MyColors.whiteColor,
            ),
            ///// approval date
            MyText(
              title: approvalDate,
              fontSize: 13,
              color: MyColors.lightgrayColor,
            ),
            SizedBox(
              height: height * 0.05,
            ),
            MyText(
              title:
                  "Student attenance is alreday marked as leave, if you wish to change this status, you have the option to either delete or update their attendance record. You can select the $studentName from \"All students screen\" and then take the desired action accordingly.",
              fontSize: 18,
              color: MyColors.lightgrayColor,
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Obx(() {
              return MyTextButton(
                title: "Mark as Read",
                loading: loadingGetx.isLoading.value,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                onPressed: () {
                  attendanceViewModel.markLeaveApprovalAsRead(context, approvalId);
                },
                backgroundColor: MyColors.whiteColor,
                progressIndicatorColor: MyColors.blackColor,
                width: width * 0.36,
                height: height * 0.05,
              );
            })
          ],
        ),
      ),
    );
  }
}
