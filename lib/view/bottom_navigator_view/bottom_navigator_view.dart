import 'package:attendancemanagementsystem/res/my_colors/my_colors.dart';
import 'package:attendancemanagementsystem/res/widgets/my_text.dart';
import 'package:attendancemanagementsystem/view/admin_view/all_students_view/all_students_view.dart';
import 'package:attendancemanagementsystem/view/profile_view/profile_view.dart';
import 'package:attendancemanagementsystem/view/student_view/student_attandance_view/student_attandance_view.dart';
import 'package:attendancemanagementsystem/view_model/getx/logedIn_user_data_getx/logedIn_user_data.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigatorView extends StatefulWidget {
  const BottomNavigatorView({super.key});

  @override
  State<BottomNavigatorView> createState() => _BottomNavigatorViewState();
}

class _BottomNavigatorViewState extends State<BottomNavigatorView> {
  final LogedInUserDataGetx logedInUserDataGetx =
      Get.put(LogedInUserDataGetx());

  int selectedRouteIndex = 0;

  /////// admin views list /////////
  final List adminViews = [
    AllStudentsView(),
    ProfileView(),
    ProfileView(),
  ];

  /////// sytudent views list /////////
  final List studentViews = [
    StudentAttendanceView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (logedInUserDataGetx.userDataList.isEmpty) {
        return Scaffold(
          backgroundColor: MyColors.blackColor,
          appBar: AppBar(
            title: MyText(
              title: "Loading...",
              color: MyColors.whiteColor,
              fontWeight: FontWeight.bold,
            ),
            backgroundColor: MyColors.blackColor,
            // shadowColor: MyColors.whiteColor,
            elevation: 14,
          ),
          body: Center(
            child: CircularProgressIndicator(
              color: MyColors.whiteColor,
            ),
          ),
        );
      } else {
        return logedInUserDataGetx.userDataList[0].userType == 'admin'
            ? Scaffold(
                backgroundColor: MyColors.blackColor,
                bottomNavigationBar: CurvedNavigationBar(
                  backgroundColor: MyColors.lightBlackColor,
                  color: MyColors.blackColor,
                  onTap: (value) {
                    setState(() {
                      selectedRouteIndex = value;
                    });
                  },
                  items: [
                    Icon(
                        selectedRouteIndex == 0
                            ? Icons.home
                            : Icons.home_outlined,
                        color: selectedRouteIndex == 0
                            ? MyColors.whiteColor
                            : MyColors.lightgrayColor,
                        size: 32),
                    Icon(
                        selectedRouteIndex == 1
                            ? Icons.mail
                            : Icons.mail_outline,
                        color: selectedRouteIndex == 1
                            ? MyColors.whiteColor
                            : MyColors.lightgrayColor,
                        size: 32),
                    Icon(Icons.person_pin,
                        color: selectedRouteIndex == 2
                            ? MyColors.whiteColor
                            : MyColors.lightgrayColor,
                        size: 32),
                  ],
                ),
                body: adminViews[selectedRouteIndex],
              )
            : Scaffold(
                backgroundColor: MyColors.blackColor,
                bottomNavigationBar: CurvedNavigationBar(
                  backgroundColor: MyColors.lightBlackColor,
                  color: MyColors.blackColor,
                  onTap: (value) {
                    setState(() {
                      selectedRouteIndex = value;
                    });
                  },
                  items: [
                    Icon(
                        selectedRouteIndex == 0
                            ? Icons.check_circle
                            : Icons.check_circle_outline,
                        color: selectedRouteIndex == 0
                            ? MyColors.whiteColor
                            : MyColors.lightgrayColor,
                        size: 32),
                    Icon(Icons.person_pin,
                        color: selectedRouteIndex == 2
                            ? MyColors.whiteColor
                            : MyColors.lightgrayColor,
                        size: 32),
                  ],
                ),
                body: studentViews[selectedRouteIndex],
              );
      }
    });
  }
}
