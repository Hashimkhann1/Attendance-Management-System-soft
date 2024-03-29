


import 'dart:async';

import 'package:attendancemanagementsystem/view/admin_view/all_students_view/all_students_view.dart';
import 'package:attendancemanagementsystem/view/auth_view/sign_in_view/sign_in_view.dart';
import 'package:attendancemanagementsystem/view/bottom_navigator_view/bottom_navigator_view.dart';
import 'package:attendancemanagementsystem/view_model/get_logedin_user_data/get_logedin_user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashViewModel {

  final _auth = FirebaseAuth.instance;

  final GetLogedInUserData getLogedInUserData = GetLogedInUserData();

  Future<void> splashTime(BuildContext context) async {
    Future.delayed(Duration(seconds: 3) , () {
      if(_auth.currentUser != null){
        getLogedInUserData.getUserData();
        Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavigatorView()));
      }else{
        Navigator.push(context, MaterialPageRoute(builder: (context) => SignInView()));
      }
    });
  }

}