import 'package:attendancemanagementsystem/res/my_colors/my_colors.dart';
import 'package:attendancemanagementsystem/res/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StudentAttendanceView extends StatelessWidget {
  const StudentAttendanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.blackColor,
      appBar: AppBar(
        title: MyText(
          title: "Sign Up",
          fontWeight: FontWeight.bold,
          color: MyColors.whiteColor,
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: MyColors.blackColor,
        shadowColor: MyColors.whiteColor,
        elevation: 16,
      ),
      body: PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            SystemNavigator.pop();
          },
          child: Column()
      ),
    );
  }
}
