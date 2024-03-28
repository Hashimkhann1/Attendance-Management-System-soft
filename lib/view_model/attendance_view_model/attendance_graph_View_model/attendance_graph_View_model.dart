



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AttendanceGraphViewModel extends GetxController {

  RxInt totalAttendance = 0.obs;
  RxInt totalPresent = 0.obs;
  RxInt totalLeave = 0.obs;

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

      var attendanceData = await FirebaseFirestore.instance.collection('users').doc(userId).collection('attendance').get();
      if(attendanceData.docs.isNotEmpty){
        attendanceData.docs.forEach((element) {
          setAttendanceValues(element.data()['attendance']);
        });
        totalAttendance.value = attendanceData.docs.length;
      }
    }catch(error){
      print(">>>>>>>>>>> erroe while getting attendance values for graph from AttendanceGraphViewModel ");
    }
  }

}