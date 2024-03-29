


import 'package:attendancemanagementsystem/model/user_model/user_model.dart';
import 'package:attendancemanagementsystem/res/constant/constant.dart';
import 'package:attendancemanagementsystem/view_model/getx/logedIn_user_data_getx/logedIn_user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class GetLogedInUserData {

  final _auth  = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance.collection('users');

  final Constant constant = Constant();
  final LogedInUserDataGetx logedInUserDataGetx = Get.put(LogedInUserDataGetx());

  void getUserData() async {
    try{
      DocumentSnapshot<Map<String , dynamic>> data =  await _firestore.doc(_auth.currentUser!.uid.toString()).get();

      if(data.data() != null){

        ///////// passing through model ///////////
        dynamic userData = await UserModel.fromJson(data.data()!);

        ///////// adding userData to List ////////
        logedInUserDataGetx.userDataList.add(userData);


      }
    }catch(error){
      print(">>>>>>>>>> error while getting logedin user Data from GetLogedInUserData $error");
    }
  }
}