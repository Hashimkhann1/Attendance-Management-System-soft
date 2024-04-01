import 'package:attendancemanagementsystem/res/constant/constant.dart';
import 'package:attendancemanagementsystem/res/my_colors/my_colors.dart';
import 'package:attendancemanagementsystem/res/widgets/my_text.dart';
import 'package:attendancemanagementsystem/res/widgets/my_text_button.dart';
import 'package:attendancemanagementsystem/res/widgets/my_textformfield.dart';
import 'package:attendancemanagementsystem/view/admin_view/create_report_view/create_report_view.dart';
import 'package:attendancemanagementsystem/view_model/attendance_view_model/attendance_graph_View_model/attendance_graph_View_model.dart';
import 'package:attendancemanagementsystem/view_model/report_view_model/report_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpecificReportView extends StatelessWidget {
  SpecificReportView({super.key});

  // final _formKey  = GlobalKey<FormState>();
  // final reportDescriptionController = TextEditingController();

  final AttendanceGraphViewModel attendanceGraphViewModel =
      Get.put(AttendanceGraphViewModel());
  final ReportViewModel reportViewModel = ReportViewModel();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: MyColors.blackColor,
      appBar: AppBar(
        title: MyText(
          title: "Create specific report",
          color: MyColors.whiteColor,
          fontWeight: FontWeight.w500,
        ),
        iconTheme: IconThemeData(color: MyColors.whiteColor),
        centerTitle: true,
        backgroundColor: MyColors.blackColor,
        shadowColor: MyColors.whiteColor,
        elevation: 14,
      ),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.05,
          ),
          MyText(
            title: "Select FROM  and TO Date to create report",
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: MyColors.lightgrayColor,
          ),
          SizedBox(
            height: height * 0.03,
          ),

          //////// create report button ////
          Obx(() {
            return attendanceGraphViewModel.selectedDatesForSpecificReport.length != 2 ? SizedBox() :MyTextButton(
              title: 'Create Report',
              textColor: MyColors.whiteColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              onPressed: () {
                reportViewModel.checkDatesForSpecificAttendance();
              },
              backgroundColor: MyColors.lightBlackColor,
              width: width * 0.40,
              height: height * 0.05,
            );
          }),
          SizedBox(
            height: height * 0.03,
          ),

          /////// all dates ////////
          Expanded(
            child: ListView.builder(
                itemCount: attendanceGraphViewModel.allAttendanceDates.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      if (attendanceGraphViewModel.selectedDatesForSpecificReport.length != 2 || attendanceGraphViewModel.selectedDatesForSpecificReport.contains(attendanceGraphViewModel.allAttendanceDates[index])) {
                        if (attendanceGraphViewModel.selectedDatesForSpecificReport.contains(attendanceGraphViewModel.allAttendanceDates[index])) {
                          attendanceGraphViewModel.selectedDatesForSpecificReport.remove(attendanceGraphViewModel.allAttendanceDates[index]);
                        } else {
                          attendanceGraphViewModel.selectedDatesForSpecificReport.add(attendanceGraphViewModel.allAttendanceDates[index]);
                        }
                      } else {
                        Constant()
                            .toastMessage("You can only select only Two Dates");
                      }
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: 6),
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                            color: MyColors.lightBlackColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: Obx(() {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText(
                                title: attendanceGraphViewModel
                                    .allAttendanceDates[index]
                                    .toString(),
                                color: MyColors.whiteColor,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                              attendanceGraphViewModel
                                      .selectedDatesForSpecificReport
                                      .contains(attendanceGraphViewModel.allAttendanceDates[index])
                                  ? Icon(
                                      Icons.check,
                                      color: MyColors.whiteColor,
                                    )
                                  : SizedBox(),
                            ],
                          );
                        })),
                  );
                }),
          )
        ],
      ),
    );
  }
}
