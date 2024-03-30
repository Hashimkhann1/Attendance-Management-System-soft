import 'package:attendancemanagementsystem/res/my_colors/my_colors.dart';
import 'package:attendancemanagementsystem/res/widgets/my_text.dart';
import 'package:attendancemanagementsystem/res/widgets/my_text_button.dart';
import 'package:attendancemanagementsystem/view/admin_view/check_student_attendance_view/check_student_attendance.dart';
import 'package:attendancemanagementsystem/view_model/attendance_view_model/attendance_view_model.dart';
import 'package:attendancemanagementsystem/view_model/getx/logedIn_user_data_getx/logedIn_user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class StudentAttendanceView extends StatefulWidget {
  StudentAttendanceView({super.key});

  @override
  State<StudentAttendanceView> createState() => _StudentAttendanceViewState();
}

class _StudentAttendanceViewState extends State<StudentAttendanceView> {
  final AttendanceViewModel attendanceViewModel =
      Get.put(AttendanceViewModel());

  final LogedInUserDataGetx logedInUserDataGetx =
      Get.put(LogedInUserDataGetx());

  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    attendanceViewModel.checkToadyAttendace();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: MyColors.blackColor,
        appBar: AppBar(
          title: MyText(
            title: "Mark Attendance",
            fontWeight: FontWeight.bold,
            color: MyColors.whiteColor,
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: MyColors.blackColor,
          shadowColor: MyColors.whiteColor,
          elevation: 16,
        ),
        body: Obx(() {
          return attendanceViewModel.isTodayAttendanceExist.value == 'loading'
              ? Center(
                  child: CircularProgressIndicator(
                  color: MyColors.whiteColor,
                ))
              : PopScope(
                  canPop: false,
                  onPopInvoked: (didPop) {
                    SystemNavigator.pop();
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.06,
                      ),
                      MyTextButton(
                        title: "Mark present",
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        textColor: MyColors.whiteColor,
                        onPressed: () {
                          attendanceViewModel.showAttendanceDialog(
                              context, 'present');
                        },
                        width: width,
                        height: height * 0.10,
                        backgroundColor: MyColors.lightBlackColor,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      MyTextButton(
                        title: "Mark leave",
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        textColor: MyColors.whiteColor,
                        onPressed: () {
                          attendanceViewModel.showAttendanceDialog(
                              context, 'leave');
                        },
                        width: width,
                        height: height * 0.10,
                        backgroundColor: MyColors.lightBlackColor,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      MyTextButton(
                        title: "View Attendance",
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        textColor: MyColors.whiteColor,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CheckStudentAttendanceView(
                                        studentId:
                                            _auth.currentUser!.uid.toString(),
                                        userRegisterDate: logedInUserDataGetx
                                            .userDataList[0].registerData.toDate(),
                                      )));
                        },
                        width: width,
                        height: height * 0.10,
                        backgroundColor: MyColors.lightBlackColor,
                      ),
                    ],
                  ));
        }));
  }
}
