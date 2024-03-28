import 'package:attendancemanagementsystem/res/my_colors/my_colors.dart';
import 'package:attendancemanagementsystem/res/widgets/my_text.dart';
import 'package:attendancemanagementsystem/res/widgets/my_text_button.dart';
import 'package:attendancemanagementsystem/res/widgets/my_textformfield.dart';
import 'package:attendancemanagementsystem/view/auth_view/sign_up_view/sign_up_view.dart';
import 'package:attendancemanagementsystem/view_model/auth_view_model/auth_view_model.dart';
import 'package:attendancemanagementsystem/view_model/getx/loading_getx/loading_getx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SignInView extends StatelessWidget {
  SignInView({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  /////////// loading getx ///////////
  final LoadingGetx loadingGetx = Get.put(LoadingGetx());

  /////////// auth view model ///////////
  final AuthViewModel authViewModel = AuthViewModel();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: MyColors.blackColor,
      appBar: AppBar(
        title: MyText(
          title: "Sign In",
          color: MyColors.whiteColor,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        backgroundColor: MyColors.blackColor,
        shadowColor: MyColors.whiteColor,
        elevation: 14,
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          SystemNavigator.pop();
        },
        child: Center(
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
                            controller: emailController,
                            hintText: "Email",
                            hintTextColor: MyColors.whiteColor,
                            textColor: MyColors.whiteColor,
                            fillColor: MyColors.lightBlackColor,
                            validator: (value) {
                              if(value!.isEmpty){
                                return "Enter email";
                              }else if(!value.contains("@gmail.com")){
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
                            obscureText: true,
                            hintTextColor: MyColors.whiteColor,
                            textColor: MyColors.whiteColor,
                            fillColor: MyColors.lightBlackColor,
                            validator: (value) {
                              if(value!.isEmpty){
                                return "Enter password";
                              }else if(value.length <= 7){
                                return "Password must be grather than 7 chanacters";
                              }
                              return null;
                            },
                          ),
                        ],
                      )
                  ),
                  SizedBox(height: height * 0.03,),
                  Obx(() {
                    return MyTextButton(
                      title: "Sign In",
                      loading: loadingGetx.isLoading.value,
                      fontSize: 18,
                      textColor: MyColors.whiteColor,
                      fontWeight: FontWeight.bold,
                      onPressed: () {
                        if(_formKey.currentState!.validate()){
                          authViewModel.signIn(context, emailController.text, passwordController.text);
                        }
                      },
                      backgroundColor: MyColors.lightBlackColor,
                      width: width * 0.90,
                      height: height * 0.06,
                    );
                  }),
                  SizedBox(height: height * 0.01,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText(title: 'Don\'t have an account',color: MyColors.whiteColor,),
                      SizedBox(width: width * 0.01,),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Sign_up_view()));
                        },
                        child: MyText(title: "Register",fontSize: 16,fontWeight: FontWeight.w600,color: Colors.blue,),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
