import 'package:attendancemanagementsystem/res/my_colors/my_colors.dart';
import 'package:attendancemanagementsystem/res/widgets/my_text.dart';
import 'package:attendancemanagementsystem/res/widgets/my_text_button.dart';
import 'package:attendancemanagementsystem/view/admin_view/check_student_attendance_view/edit_attendance_view/edit_attendance_view.dart';
import 'package:attendancemanagementsystem/view_model/attendance_view_model/attendance_graph_View_model/attendance_graph_View_model.dart';
import 'package:attendancemanagementsystem/view_model/attendance_view_model/attendance_view_model.dart';
import 'package:attendancemanagementsystem/view_model/getx/logedIn_user_data_getx/logedIn_user_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudenAttendanceGraph extends StatelessWidget {
  final String? studentId;

  StudenAttendanceGraph({super.key, this.studentId});

  ////////// logedin user data list ////////////
  final LogedInUserDataGetx logedInUserDataGetx =
      Get.put(LogedInUserDataGetx());

  ////////// attendance Graph data ////////////
  final AttendanceGraphViewModel attendanceGraphViewModel =
      Get.put(AttendanceGraphViewModel());

  ////////// attendanceViewModel data ////////////
  final AttendanceViewModel attendanceViewModel =
      Get.put(AttendanceViewModel());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
        width: width,
        height: height * 0.27,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: MyColors.lightBlackColor,
            borderRadius: BorderRadius.circular(12)),
        child: Obx(() {
          final totalAttendance =
              attendanceGraphViewModel.totalAttendance.value.toInt();
          final totalPresent =
              attendanceGraphViewModel.totalPresent.value.toInt();
          final totalLeave = attendanceGraphViewModel.totalLeave.value.toInt();

          return Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      logedInUserDataGetx.userDataList[0].userType == 'admin'
                          ? const SizedBox()
                          : MyText(
                              title: attendanceViewModel
                                          .isTodayAttendanceExist.value ==
                                      'exist'
                                  ? "Toady attendace is saved"
                                  : "Toady attendace is not saved",
                              color: MyColors.whiteColor,
                            ),
                      Row(
                        children: [
                          const MyText(
                            title: "Total attendance",
                            color: MyColors.whiteColor,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          MyText(
                            title: totalAttendance == 0
                                ? "..."
                                : totalAttendance.toString(),
                            color: MyColors.whiteColor,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const MyText(
                            title: "Total present",
                            color: MyColors.whiteColor,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          MyText(
                            title: totalPresent == 0
                                ? "..."
                                : totalPresent.toString(),
                            color: MyColors.whiteColor,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const MyText(
                            title: "Total leave",
                            color: MyColors.whiteColor,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          MyText(
                            title:
                                totalLeave == 0 ? "..." : totalLeave.toString(),
                            color: MyColors.whiteColor,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ],
                  ),

                  ////////// edit and add attendance button for admin ////////
                  logedInUserDataGetx.userDataList[0].userType != 'admin'
                      ? const SizedBox()
                      : Column(
                          children: [
                            MyTextButton(
                              title: "Add attendance",
                              fontWeight: FontWeight.bold,
                              onPressed: () {},
                              width: width * 0.32,
                              height: height * 0.04,
                              backgroundColor: MyColors.whiteColor,
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            MyTextButton(
                              title: "Edit attendance",
                              fontWeight: FontWeight.bold,
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => EditAttendanceView(studentId: studentId,)));
                              },
                              width: width * 0.32,
                              height: height * 0.04,
                              backgroundColor: MyColors.whiteColor,
                            ),
                          ],
                        )
                ],
              ),

              /////////// chart code //////////
              totalAttendance != 0
                  ? Expanded(
                      child: PieChart(PieChartData(
                          sectionsSpace: 1,
                          centerSpaceRadius: 0,
                          sections: [
                            // Present chart data
                            PieChartSectionData(
                                value: (totalPresent.toInt() /
                                        totalAttendance.toInt() *
                                        100)
                                    .toDouble(),
                                color: Colors.green,
                                title:
                                    '${(totalPresent.toInt() / totalAttendance.toInt() * 100).roundToDouble().truncate()}%',
                                titleStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                radius: width * 0.20),

                            // Leave chart data
                            PieChartSectionData(
                                value: (totalLeave.toInt() /
                                        totalAttendance.toInt() *
                                        100)
                                    .toDouble(),
                                color: Colors.yellow,
                                title:
                                    '${(totalLeave.toInt() / totalAttendance.toInt() * 100).roundToDouble().truncate()}%',
                                titleStyle: const TextStyle(
                                    color: MyColors.blackColor,
                                    fontWeight: FontWeight.bold),
                                radius: width * 0.20),
                          ])),
                    )
                  : MyText(
                      title: "Loading Graph...",
                      fontSize: 16,
                      color: MyColors.whiteColor,
                    ),
            ],
          );
        }));
  }
}
