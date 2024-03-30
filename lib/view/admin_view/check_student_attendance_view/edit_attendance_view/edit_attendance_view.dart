import 'package:attendancemanagementsystem/res/my_colors/my_colors.dart';
import 'package:attendancemanagementsystem/res/widgets/my_text.dart';
import 'package:attendancemanagementsystem/view_model/attendance_view_model/attendance_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditAttendanceView extends StatelessWidget {
  final String? studentId;

  EditAttendanceView({super.key , this.studentId});

  final AttendanceViewModel attendanceViewModel = AttendanceViewModel();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: MyColors.blackColor,
        appBar: AppBar(
          title: MyText(
            title: "edit attendance",
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
              .doc(studentId)
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
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 25),
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        attendanceViewModel.showUpdateAttendanceDialog(context, snapshot.data!.docs[index]['attendance'].toString() == 'present' ? 'leave' : 'present' , studentId, snapshot.data!.docs[index].id.toString());
                      },
                      child: Container(
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
                                Icon(Icons.edit,color: MyColors.whiteColor,),
                                SizedBox(width: width * 0.02),
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
                      ),
                    );
                  }),
            );
          })
    );
  }
}
