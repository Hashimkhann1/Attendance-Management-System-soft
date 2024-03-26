import 'package:attendancemanagementsystem/res/my_colors/my_colors.dart';
import 'package:attendancemanagementsystem/view/admin_view/admin_profile_view/admin_profile_view.dart';
import 'package:attendancemanagementsystem/view/admin_view/all_students_view/all_students_view.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNavigatorView extends StatefulWidget {
  const BottomNavigatorView({super.key});

  @override
  State<BottomNavigatorView> createState() => _BottomNavigatorViewState();
}

class _BottomNavigatorViewState extends State<BottomNavigatorView> {

  int selectedRouteIndex = 0;

  final List adminViews = [
    AllStudentsView(),
    AdminProfileView(),
    AdminProfileView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.blackColor,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: MyColors.lightBlackColor,
        color: MyColors.blackColor,
        onTap: (value) {
          setState(() {
            selectedRouteIndex = value;
            print(value);
          });
        },
        items: [
          Icon( selectedRouteIndex == 0 ? Icons.home : Icons.home_outlined,color: selectedRouteIndex == 0 ? MyColors.whiteColor : MyColors.lightgrayColor,size: 32),
          Icon(selectedRouteIndex == 1 ? Icons.mail : Icons.mail_outline,color: selectedRouteIndex == 1 ? MyColors.whiteColor : MyColors.lightgrayColor,size: 32),
          Icon(Icons.person_pin,color: selectedRouteIndex == 2 ? MyColors.whiteColor : MyColors.lightgrayColor,size: 32),
        ],
      ),
      body: adminViews[selectedRouteIndex],
    );
  }
}
