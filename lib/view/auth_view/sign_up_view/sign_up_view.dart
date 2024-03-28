import 'package:attendancemanagementsystem/res/my_colors/my_colors.dart';
import 'package:attendancemanagementsystem/res/widgets/my_text.dart';
import 'package:attendancemanagementsystem/res/widgets/my_text_button.dart';
import 'package:attendancemanagementsystem/res/widgets/my_textformfield.dart';
import 'package:attendancemanagementsystem/view_model/auth_view_model/auth_view_model.dart';
import 'package:attendancemanagementsystem/view_model/getx/loading_getx/loading_getx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Sign_up_view extends StatelessWidget {
  Sign_up_view({super.key});

  ////////// form key //////////
  final _formKey = GlobalKey<FormState>();

  //////// text editing controllers //////////
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  /////////// auth view model //////////
  final AuthViewModel authViewModel = AuthViewModel();

  ////////// loading getx ///////////
  final LoadingGetx loadingGetx = Get.put(LoadingGetx());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: MyColors.blackColor,
      appBar: AppBar(
        title: MyText(
          title: "Sign Up",
          fontWeight: FontWeight.bold,
          color: MyColors.whiteColor,
        ),
        iconTheme: IconThemeData(
          color: MyColors.whiteColor
        ),
        centerTitle: true,
        backgroundColor: MyColors.blackColor,
        shadowColor: MyColors.whiteColor,
        elevation: 16,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                    child: Column(
                  children: [
                    MyTextFormField(
                      controller: fullNameController,
                      hintText: "Full name",
                      hintTextColor: MyColors.whiteColor,
                      textColor: MyColors.whiteColor,
                      fillColor: MyColors.lightBlackColor,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Full name";
                        }else if (value.length <= 3) {
                          return "Full name must e grater than 3 characters";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    MyTextFormField(
                      controller: emailController,
                      hintText: "Email",
                      hintTextColor: MyColors.whiteColor,
                      textColor: MyColors.whiteColor,
                      fillColor: MyColors.lightBlackColor,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Email";
                        }else if (!value.contains('@gmail.com')) {
                          return "Enter valid email";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    MyTextFormField(
                      controller: passwordController,
                      hintText: "Password",
                      hintTextColor: MyColors.whiteColor,
                      textColor: MyColors.whiteColor,
                      fillColor: MyColors.lightBlackColor,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Password";
                        } else if (value.length <= 7) {
                          return "Password must be grather than 7 characters";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    MyTextFormField(
                      controller: confirmPasswordController,
                      hintText: "Confirm password",
                      obscureText: true,
                      hintTextColor: MyColors.whiteColor,
                      textColor: MyColors.whiteColor,
                      fillColor: MyColors.lightBlackColor,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Password";
                        } else if (value != passwordController.text) {
                          return "Confirm password not matched";
                        }
                        return null;
                      },
                    ),
                  ],
                )),
                SizedBox(
                  height: height * 0.03,
                ),
                Obx(() {
                  return MyTextButton(
                    title: "Sign Up",
                    loading: loadingGetx.isLoading.value,
                    fontSize: 18,
                    textColor: MyColors.whiteColor,
                    fontWeight: FontWeight.bold,
                    backgroundColor: MyColors.lightBlackColor,
                    width: width * 0.90,
                    height: height * 0.06,
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        authViewModel.signUp(context, emailController.text, passwordController.text , fullNameController.text);
                      }
                    },
                  );
                }),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(title: 'Already have an account',color: MyColors.whiteColor,),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: MyText(
                        title: "Sign In",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
