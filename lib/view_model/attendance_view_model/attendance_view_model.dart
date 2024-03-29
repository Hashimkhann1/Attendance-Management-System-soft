import 'package:attendancemanagementsystem/res/constant/constant.dart';
import 'package:attendancemanagementsystem/res/my_colors/my_colors.dart';
import 'package:attendancemanagementsystem/res/widgets/my_text.dart';
import 'package:attendancemanagementsystem/res/widgets/my_text_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class AttendanceViewModel extends GetxController {
  final _firestore = FirebaseFirestore.instance.collection('users');
  final _auth = FirebaseAuth.instance;

  final Constant constant = Constant();

  RxString isTodayAttendanceExist = 'loading'.obs;

  /////////// save attendance method //////////////
  void saveAttendnace(BuildContext context, attendanceStatus) async {
    try {
      await _firestore
          .doc(_auth.currentUser!.uid.toString())
          .collection('attendance')
          .doc(
              "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}")
          .set({
        "attendance": attendanceStatus,
        "date": Timestamp.now(),
      }).then((value) {
        constant.toastMessage("Attendance saved succesfully");
        isTodayAttendanceExist.value = 'exist';
      });
    } catch (error) {
      print(
          " >>>>>>>>>>> Error while saving or marking attendance from AttendanceViewModel $error");
    }
  }

  /////////// check today attendace method //////////
  void checkToadyAttendace() async {
    try{
     var allAttendanceData = await _firestore.doc(_auth.currentUser!.uid.toString()).collection('attendance').get();
     if(allAttendanceData.docs.isNotEmpty) {
       //////// looping all docs //////////
       for(var element in allAttendanceData.docs){
         if(element.id.toString() == '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}'){
           isTodayAttendanceExist.value = 'exist';
         }else{
           isTodayAttendanceExist.value = 'notExist';
         }
       }
     }else{
       isTodayAttendanceExist.value = 'notExist';
     }
       }catch(error){
      print(">>>>>>>> error while checking toady attendace from AttendanceViewModel $error");
    }
  }

  ////////// update attendance ////////////
  void updateAttendance(BuildContext context , String userId , attendanceData , attendanceStatus) async {
    try{
      await _firestore.doc(userId).collection('attendance').doc(attendanceData).update({
        "attendance" : attendanceStatus
      }).then((value) {
        constant.toastMessage("Attendance updated successfully");
      });
    }catch(error){
      print(">>>>>>>>> error while update attendance from AttendanceViewModel $error");
    }
  }

  showUpdateAttendanceDialog(BuildContext context, String attendanceStatus , userId , attendanceData) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content:
          MyText(title: "Mark this attendance as ${attendanceStatus}",fontWeight: FontWeight.w600,fontSize: 20,),
          actions: [
            MyTextButton(
              title: 'No',
              textColor: MyColors.whiteColor,
              backgroundColor: MyColors.lightBlackColor,
              onPressed: () {
                Navigator.pop(context);
              },
              width: MediaQuery.of(context).size.width * 0.18,
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            MyTextButton(
              title: 'Yes',
              textColor: MyColors.whiteColor,
              backgroundColor: MyColors.lightBlackColor,
              onPressed: () {
                updateAttendance(context, userId , attendanceData , attendanceStatus );
                Navigator.pop(context);
              },
              width: MediaQuery.of(context).size.width * 0.18,
              height: MediaQuery.of(context).size.height * 0.04,
            )
          ],
        ));
  }

  /////////// alert dialog for student to add attenance //////////////
  showAttendanceDialog(BuildContext context, attendanceStatus) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content:
                  MyText(title: isTodayAttendanceExist.value == 'exist' ? "Today attendance is saved!" : "Mark your attendance as ${attendanceStatus}",fontWeight: FontWeight.w600,fontSize: 20,),
          actions: [
            MyTextButton(
                    title: isTodayAttendanceExist.value == 'exist' ? "Cancle" : 'No',
                    textColor: MyColors.whiteColor,
                    backgroundColor: MyColors.lightBlackColor,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  width: MediaQuery.of(context).size.width * 0.18,
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
            isTodayAttendanceExist.value == 'exist' ? SizedBox() : MyTextButton(
                  title: 'Yes',
                  textColor: MyColors.whiteColor,
                  backgroundColor: MyColors.lightBlackColor,
                  onPressed: () {
                    saveAttendnace(context, attendanceStatus);
                    Navigator.pop(context);
                  },
                  width: MediaQuery.of(context).size.width * 0.18,
                  height: MediaQuery.of(context).size.height * 0.04,
                )
              ],
            ));
  }
}
