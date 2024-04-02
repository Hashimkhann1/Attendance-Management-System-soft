import 'package:attendancemanagementsystem/res/my_colors/my_colors.dart';
import 'package:attendancemanagementsystem/res/widgets/my_text.dart';
import 'package:attendancemanagementsystem/view/admin_view/check_student_attendance_view/student_attendance_graph/student_attendance_graph.dart';
import 'package:attendancemanagementsystem/view/admin_view/create_report_view/create_report_view.dart';
import 'package:attendancemanagementsystem/view_model/attendance_view_model/attendance_graph_View_model/attendance_graph_View_model.dart';
import 'package:attendancemanagementsystem/view_model/attendance_view_model/attendance_view_model.dart';
import 'package:attendancemanagementsystem/view_model/getx/logedIn_user_data_getx/logedIn_user_data.dart';
import 'package:attendancemanagementsystem/view_model/report_view_model/report_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckStudentAttendanceView extends StatefulWidget {

  final String studentId;
  final String? studentName;
  final DateTime userRegisterDate;

  CheckStudentAttendanceView({super.key,required this.studentId , required this.userRegisterDate , this.studentName});

  @override
  State<CheckStudentAttendanceView> createState() => _CheckStudentAttendanceViewState();}

class _CheckStudentAttendanceViewState extends State<CheckStudentAttendanceView> {

  final LogedInUserDataGetx logedInUserDataGetx = Get.put(LogedInUserDataGetx());
  final AttendanceGraphViewModel attendanceGraphViewModel = Get.put(AttendanceGraphViewModel());
  final AttendanceViewModel attendanceViewModel = Get.put(AttendanceViewModel());
  final ReportViewModel reportViewModel = ReportViewModel();

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    attendanceGraphViewModel.getAttendanceForGraph(widget.studentId);
    });
    super.initState();
  }

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
          iconTheme: IconThemeData(color: MyColors.whiteColor),
          centerTitle: true,
          backgroundColor: MyColors.blackColor,
          shadowColor: MyColors.whiteColor,
          elevation: 14,
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(widget.studentId)
                .collection('attendance')
                .orderBy('date', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return CircularProgressIndicator(
                  color: Colors.red,
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  color: MyColors.whiteColor,
                ));
              }
              return snapshot.data!.docs.length == 0 ? Center(child: MyText(title: "Attendance is taken yet!",color: MyColors.whiteColor,fontSize: 20,fontWeight: FontWeight.bold,)) : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.03,
                    ),

                    ////////////////////////////////////////////////
                    /////////// student attendance graph ///////////
                    ////////////////////////////////////////////////
                    StudenAttendanceGraph(studentId: widget.studentId,userRegisterDate: widget.userRegisterDate,),

                    SizedBox(
                      height: height * 0.01,
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: width,
                              margin: EdgeInsets.symmetric(vertical: 5),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 12),
                              decoration: BoxDecoration(
                                  color: MyColors.lightBlackColor,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      logedInUserDataGetx.userDataList[0].userType != 'admin' ? SizedBox() : InkWell(
                                        onTap: (){
                                          attendanceViewModel.showDeleteAttendanceDialog(context, widget.studentId, snapshot.data!.docs[index].id.toString());
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: MyColors.whiteColor,
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.02,
                                      ),
                                      MyText(
                                        title: snapshot.data!.docs[index].id
                                            .toString(),
                                        color: MyColors.whiteColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19,
                                      ),
                                    ],
                                  ),
                                  MyText(
                                    title: snapshot
                                        .data!.docs[index]['attendance']
                                        .toString(),
                                    color: MyColors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  )
                                ],
                              ),
                            );
                          }),
                    ),

                    ////////////////////////////////////////////////////
                    ////////////// create report button ////////////////
                    Obx(() {
                      return attendanceGraphViewModel.totalAttendance == 0 ? SizedBox() : InkWell(
                        onTap: () {
                          reportViewModel.showBottomSheetForButtons(context , widget.studentName.toString());
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 7,vertical: 7),
                          decoration: BoxDecoration(
                              color: MyColors.whiteColor,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: MyText(title: "Create Report",fontSize: 16,fontWeight: FontWeight.w600,),
                        ),
                      );
                    })
                  ],
                ),
              );
            }),
    );
  }
}
