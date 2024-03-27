import 'package:attendancemanagementsystem/res/my_colors/my_colors.dart';
import 'package:attendancemanagementsystem/res/widgets/my_profile_card.dart';
import 'package:attendancemanagementsystem/res/widgets/my_text.dart';
import 'package:attendancemanagementsystem/view_model/auth_view_model/auth_view_model.dart';
import 'package:attendancemanagementsystem/view_model/getx/logedIn_user_data_getx/logedIn_user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final AuthViewModel authViewModel = AuthViewModel();
  final LogedInUserDataGetx logedInUserDataGetx = Get.put(LogedInUserDataGetx());

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
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 66,
                backgroundColor: MyColors.lightBlackColor,
              ),
              Positioned(
                bottom: 2,
                right: 8,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: MyColors.lightgrayColor,
                    shape: BoxShape.circle
                  ),
                  child: Icon(Icons.camera_alt,color: MyColors.lightBlackColor,),
                ),
              )
            ],
          ),
          SizedBox(
            height: height * 0.06,
          ),
          MyProfileCard(title: logedInUserDataGetx.userDataList[0].userName.toString()),
          MyProfileCard(
            title: logedInUserDataGetx.userDataList[0].userEmail.toString(),
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
