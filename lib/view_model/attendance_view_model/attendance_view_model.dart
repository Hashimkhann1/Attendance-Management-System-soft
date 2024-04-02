import 'package:attendancemanagementsystem/res/constant/constant.dart';
import 'package:attendancemanagementsystem/res/my_colors/my_colors.dart';
import 'package:attendancemanagementsystem/res/widgets/my_text.dart';
import 'package:attendancemanagementsystem/res/widgets/my_text_button.dart';
import 'package:attendancemanagementsystem/view_model/attendance_view_model/attendance_graph_View_model/attendance_graph_View_model.dart';
import 'package:attendancemanagementsystem/view_model/getx/loading_getx/loading_getx.dart';
import 'package:attendancemanagementsystem/view_model/getx/logedIn_user_data_getx/logedIn_user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class AttendanceViewModel extends GetxController {
  final _firestore = FirebaseFirestore.instance.collection('users');
  final _auth = FirebaseAuth.instance;

  final LogedInUserDataGetx logedInUserDataGetx = Get.put(LogedInUserDataGetx());
  final AttendanceGraphViewModel attendanceGraphViewModel = AttendanceGraphViewModel();
  final LoadingGetx loadingGetx = Get.put(LoadingGetx());

  final Constant constant = Constant();

  RxString isTodayAttendanceExist = 'loading'.obs;

  /////////// save attendance for student method //////////////
  void saveAttendnace(BuildContext context, attendanceStatus) async {
    try {
      await _firestore
          .doc(_auth.currentUser!.uid.toString())
          .collection('attendance')
          .doc(
              "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}")
          .set({
        "attendance": attendanceStatus,
        "date": DateTime.now(),
      }).then((value) {
        constant.toastMessage("Attendance saved succesfully");
        if(attendanceStatus == 'leave'){
          leaveApproval();
        }
        isTodayAttendanceExist.value = 'exist';
      });
    } catch (error) {
      print(
          " >>>>>>>>>>> Error while saving or marking attendance from AttendanceViewModel $error");
    }
  }

  ////////// update attendance for admin ////////////
  void updateAttendance(BuildContext context , String userId , attendanceData , attendanceStatus) async {
    try{
      await _firestore.doc(userId).collection('attendance').doc(attendanceData).update({
        "attendance" : attendanceStatus
      }).then((value) {
        constant.toastMessage("Attendance updated successfully");
        attendanceGraphViewModel.getAttendanceForGraph(userId);
      });
    }catch(error){
      print(">>>>>>>>> error while update attendance from AttendanceViewModel $error");
    }
  }

  //////// delete attendance ////////////////
  void deleteAttendance(BuildContext context , String userid , deleteAttendanceDate) async {
    try{
      _firestore.doc(userid).collection('attendance').doc(deleteAttendanceDate).delete().then((value) {
        constant.toastMessage('attendance deleted');
      });
    }catch(error){
      constant.toastMessage('error while deleting attendance');
      print(error);
    }
  }


  //////// leave attendance Approval //////////
  void leaveApproval() async {
    try{

      String adminUid = '';

      //////// geting admin uid /////////
      var getAdminUid = await _firestore.where('userType' , isEqualTo: 'admin').get();
      getAdminUid.docs.forEach((element) {
        adminUid = element.data()['userId'].toString();
      });

      if(adminUid != ''){
        await _firestore.doc(adminUid).collection('leaveApproval').add({
          "approvalStatus" : 'leave',
          "studentName" : logedInUserDataGetx.userDataList[0].userName,
          'approvalReadOrUnreadStatud' : 'unRead',
          "date" : DateTime.now()
        });
      }
    }catch(error){
      print(">>>>>> error while submiting leave approval to admoin from AttendanceViewModel $error");
    }
  }

  ////////// mark leave approval as read method for admim //////////
  void markLeaveApprovalAsRead(BuildContext context, String approvalId) async {
    try{
      loadingGetx.setLoading();
      _firestore.doc(_auth.currentUser!.uid.toString()).collection('leaveApproval').doc(approvalId).update({
        'approvalReadOrUnreadStatud' : 'read'
      }).then((value) {
        loadingGetx.setLoading();
        constant.toastMessage("leave approval marked as read");
        Navigator.pop(context);
      });
    }catch(error){
      loadingGetx.setLoading();
      print('>>>>>> error while marking leave approval as read from AttendanceViewModel $error');
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

  //////////// checking attendance that attendance is exits on selected date or not ///////////////
  void checkAttendaceForAdminToAddNew(BuildContext context, String attendanceDate , userid , attendanceStatus , DateTime timeStempDate) async {
    try{

      bool attendanceExist = true;

      var allAttendanceData = await _firestore.doc(userid).collection('attendance').get();
      if(allAttendanceData.docs.isNotEmpty) {
        //////// looping all docs //////////
        for(var element in allAttendanceData.docs){
          if(element.id.toString() == attendanceDate){
            constant.toastMessage("attendnace already exist");
            attendanceExist = false;
            break;
          }
        }
        if(attendanceExist) {
          addAttendnaceForAdmin(context, attendanceDate, userid, attendanceStatus , timeStempDate);
        }
      }
    }catch(error){
      print(">>>>>>>> error while checking toady attendace from AttendanceViewModel $error");
    }
  }

  /////////// add attendance from admin method //////////////
  void addAttendnaceForAdmin(BuildContext context, String attendanceDate , userid , attendanceStatus , DateTime timeStempDate) async {
    try {
      await _firestore
          .doc(userid)
          .collection('attendance')
          .doc(attendanceDate)
          .set({
        "attendance": attendanceStatus,
        "date": timeStempDate,
      }).then((value) {
        constant.toastMessage("Attendance added succesfully");
        isTodayAttendanceExist.value = 'exist';
      });
    } catch (error) {
      print(
          " >>>>>>>>>>> Error while saving or marking attendance from AttendanceViewModel $error");
    }
  }

  ///////// add attendance date picker ///////
  void addAttendanceDatePicker(BuildContext context , DateTime userRegisterDate , String userId) {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: userRegisterDate,
        lastDate: DateTime.now()
    ).then((value) {
      if(value != null){
        // String timeStempDate = DateFormat("MMMM d, yyyy 'at' h:mm:ss a 'UTC'Z").format(value);
        DateTime timeStempDate = value;
        showAddAttendanceDialogForAdmin(context, userId , "${value.day}-${value.month}-${value.year}" , timeStempDate);
      }
    });
  }

  /////////// alert dialog for admin to add attenance //////////////
  showAddAttendanceDialogForAdmin(BuildContext context, String userId , String attendanceDate , DateTime timeStempDate) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content:
          MyText(title: "Mark this attendance as Present or Leave,",fontWeight: FontWeight.bold,fontSize: 18,),
          actions: [
            MyTextButton(
              title: 'Mark Leave',
              textColor: MyColors.whiteColor,
              backgroundColor: MyColors.lightBlackColor,
              onPressed: () {
                checkAttendaceForAdminToAddNew(context, attendanceDate, userId, 'leave' , timeStempDate);
                Navigator.pop(context);
              },
              width: MediaQuery.of(context).size.width * 0.26,
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            MyTextButton(
              title: 'Mark Present',
              textColor: MyColors.whiteColor,
              backgroundColor: MyColors.lightBlackColor,
              onPressed: () {
                checkAttendaceForAdminToAddNew(context, attendanceDate, userId, 'present' , timeStempDate);
                Navigator.pop(context);
              },
              width: MediaQuery.of(context).size.width * 0.27,
              height: MediaQuery.of(context).size.height * 0.04,
            )
          ],
        ));
  }

  /////////// alert dialog for admin to update attenance //////////////
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

  /////////// alert dialog for admin to delete attenance //////////////
  showDeleteAttendanceDialog(BuildContext context , String userid , deleteAttendanceDate) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content:
          MyText(title: "Are you sure to delete attendance",fontWeight: FontWeight.w600,fontSize: 20,),
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
                deleteAttendance(context, userid, deleteAttendanceDate);
                Navigator.pop(context);
              },
              width: MediaQuery.of(context).size.width * 0.18,
              height: MediaQuery.of(context).size.height * 0.04,
            )
          ],
        ));
  }
}
