import 'package:attendancemanagementsystem/res/my_colors/my_colors.dart';
import 'package:attendancemanagementsystem/res/widgets/my_profile_card.dart';
import 'package:attendancemanagementsystem/res/widgets/my_text.dart';
import 'package:attendancemanagementsystem/view_model/auth_view_model/auth_view_model.dart';
import 'package:flutter/material.dart';

class AdminProfileView extends StatelessWidget {
  AdminProfileView({super.key});

  final AuthViewModel authViewModel = AuthViewModel();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: MyColors.blackColor,
      appBar: AppBar(
        title: MyText(
          title: "Profile",
          color: MyColors.whiteColor,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.blackColor,
        shadowColor: MyColors.whiteColor,
        elevation: 14,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 58,
          ),
          SizedBox(
            height: height * 0.06,
          ),
          MyProfileCard(title: "M Hashim"),
          MyProfileCard(
            title: "hashim@gmail.com",
            icon: Icons.email_outlined,
          ),
          InkWell(
            onTap: () {
              authViewModel.signOut(context);
            },
              child: MyProfileCard(
            title: "Looout",
            icon: Icons.logout,
          )),
        ],
      ),
    );
  }
}
