import 'package:attendancemanagementsystem/res/constant/constant.dart';
import 'package:attendancemanagementsystem/view/admin_view/all_students_view/all_students_view.dart';
import 'package:attendancemanagementsystem/view/auth_view/sign_in_view/sign_in_view.dart';
import 'package:attendancemanagementsystem/view/bottom_navigator_view/bottom_navigator_view.dart';
import 'package:attendancemanagementsystem/view_model/get_logedin_user_data/get_logedin_user_data.dart';
import 'package:attendancemanagementsystem/view_model/getx/loading_getx/loading_getx.dart';
import 'package:attendancemanagementsystem/view_model/getx/logedIn_user_data_getx/logedIn_user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';




class AuthViewModel {

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance.collection('users');
  final Constant constant = Constant();

  ////////// loading getx ///////////
  final LoadingGetx loadingGetx = Get.put(LoadingGetx());
  final GetLogedInUserData getLogedInUserData = GetLogedInUserData();
  final LogedInUserDataGetx logedInUserDataGetx = Get.put(LogedInUserDataGetx());


  ////////// add data to ffirebase after sing up //////////
  void addUserData(String fullName , email) async {
    try{
      await _firestore.doc(_auth.currentUser!.uid).set({
        "userId" : _auth.currentUser!.uid.toString(),
        "userEmail" : email,
        "userName" : fullName,
        "userImage" : null,
        "registerData" : DateTime.now(),
        "userType" : "student",
      });
    }catch(error){
      print(">>>>>>> error while adding data after sign up from AuthViewModel $error");
    }
  }


  ////////// sign in method //////////
  void signIn(BuildContext context, String email , password) async {
    try{
      loadingGetx.setLoading();
      await _auth.signInWithEmailAndPassword(email: email, password: password).then((value) {
        constant.toastMessage("Sign in successfully");
        loadingGetx.setLoading();
        getLogedInUserData.getUserData();
        Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavigatorView()));
      });
    } on FirebaseAuthException catch(error){
      loadingGetx.setLoading();
      print(">>>>>>> Error while sign in from AuthViewModel $error");
      constant.toastMessage(error.message.toString());
    }
  }


  ////////// sign up method //////////
  signUp(BuildContext context , String email , password , fullName) async {
    loadingGetx.setLoading();
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) {
        constant.toastMessage("Sign up successfully :)");
        loadingGetx.setLoading();
        addUserData(fullName , email);
        getLogedInUserData.getUserData();
        Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavigatorView()));
      });
    }on FirebaseAuthException catch(error){
      loadingGetx.setLoading();
      print(">>>>>>>>> Error while sign up from AuthViewModel $error");
      constant.toastMessage(error.message.toString());
    }
  }


  ////////// sign out method //////////
  void signOut(BuildContext context) async {
    try{
      _auth.signOut().then((value) {
        constant.toastMessage("User sign out successfully");
        logedInUserDataGetx.userDataList.clear();
        Navigator.push(context, MaterialPageRoute(builder: (constant) => SignInView()));
      });
    }catch(error){
      print(" >>>>>>>>>>> error while signing out out from AuthViewModel $error");
    }
  }

}