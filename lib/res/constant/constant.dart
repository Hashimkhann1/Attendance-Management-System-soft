


import 'package:attendancemanagementsystem/res/my_colors/my_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Constant {

  void toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
      backgroundColor: MyColors.lightgrayColor,
      textColor: MyColors.blackColor,
    );
  }



}