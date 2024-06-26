



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class AttendanceGraphViewModel extends GetxController {

  RxInt totalAttendance = 0.obs;
  RxInt totalPresent = 0.obs;
  RxInt totalLeave = 0.obs;

  ////// create report Data /////

  ////// this list holding all attendance //////
  RxList allAttendanceForRepot = [].obs;

  ////// this list holding all attendance dates //////
  RxList allAttendanceDates = [].obs;

  ////// this list holding all attendance //////
  RxList selectedDatesForSpecificReport = [].obs;


  void setAttendanceValues(attandancevalues) {
    if(attandancevalues == 'present'){
      totalPresent.value++;
    }else{
      totalLeave.value++;
    }
  }


  void getAttendanceForGraph(String userId) async {
    try{
      totalAttendance.value = 0;
      totalPresent.value = 0;
      totalLeave.value = 0;

      var attendanceData = await FirebaseFirestore.instance.collection('users').doc(userId).collection('attendance').orderBy('date', descending: true).get();
      if(attendanceData.docs.isNotEmpty){
        allAttendanceDates.clear();
        allAttendanceForRepot.clear();
        attendanceData.docs.forEach((element) {
          allAttendanceDates.add(element.id.toString());
          allAttendanceForRepot.add({element.id.toString() : element.data()['attendance']});
          setAttendanceValues(element.data()['attendance']);
        });
        totalAttendance.value = attendanceData.docs.length;
      }
    }catch(error){
      print(">>>>>>>>>>> erroe while getting attendance values for graph from AttendanceGraphViewModel ");
    }
  }

}