import 'dart:io';

import 'package:attendancemanagementsystem/res/my_colors/my_colors.dart';
import 'package:attendancemanagementsystem/res/widgets/my_profile_card.dart';
import 'package:attendancemanagementsystem/res/widgets/my_text.dart';
import 'package:attendancemanagementsystem/res/widgets/my_text_button.dart';
import 'package:attendancemanagementsystem/view_model/auth_view_model/auth_view_model.dart';
import 'package:attendancemanagementsystem/view_model/getx/image_picker_getx/image_picker_getx.dart';
import 'package:attendancemanagementsystem/view_model/getx/loading_getx/loading_getx.dart';
import 'package:attendancemanagementsystem/view_model/getx/logedIn_user_data_getx/logedIn_user_data.dart';
import 'package:attendancemanagementsystem/view_model/profile_view_model/profile_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final AuthViewModel authViewModel = AuthViewModel();
  final LogedInUserDataGetx logedInUserDataGetx =
      Get.put(LogedInUserDataGetx());
  final LoadingGetx loadingGetx = Get.put(LoadingGetx());
  final ImagePickerGetx imagePickerGetx = Get.put(ImagePickerGetx());
  final ProfileViewModel profileViewModel = ProfileViewModel();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        SystemNavigator.pop();
      },
      child: Scaffold(
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
                Obx(() {
                  return CircleAvatar(
                      radius: 66,
                      backgroundColor: MyColors.lightBlackColor,
                      backgroundImage: imagePickerGetx
                              .selectedImagePath.value.isNotEmpty
                          ? FileImage(File(imagePickerGetx.selectedImagePath.value
                              .toString())) as ImageProvider
                          : NetworkImage(logedInUserDataGetx.userDataList[0].userImage != null ? logedInUserDataGetx.userDataList[0].userImage.toString() :
                              'https://static.vecteezy.com/system/resources/previews/004/641/880/large_2x/illustration-of-high-school-building-school-building-free-vector.jpg'));
                }),
                Positioned(
                  bottom: 2,
                  right: 8,
                  child: InkWell(
                    onTap: () {
                      imagePickerGetx.getAdminProfileImage();
                    },
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: MyColors.lightgrayColor, shape: BoxShape.circle),
                      child: Icon(
                        Icons.camera_alt,
                        color: MyColors.lightBlackColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: height * 0.03,),
            Obx(() {
              return imagePickerGetx.selectedImagePath.value != ''
                  ? MyTextButton(
                      title: "Update Image",
                      onPressed: () {
                        profileViewModel.uploadAdminImage();
                      },
                loading: loadingGetx.isLoading.value,
                backgroundColor: MyColors.lightBlackColor,
                textColor: MyColors.whiteColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                width: width * 0.36,
                height: height * 0.06,
              )
                  : SizedBox();
            }),
            SizedBox(
              height: height * 0.06,
            ),
            MyProfileCard(
                title: logedInUserDataGetx.userDataList[0].userName.toString()),
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
      ),
    );
  }
}
