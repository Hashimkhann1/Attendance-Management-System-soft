import 'package:attendancemanagementsystem/res/my_colors/my_colors.dart';
import 'package:attendancemanagementsystem/res/widgets/my_text.dart';
import 'package:attendancemanagementsystem/view_model/splash_view_model/splash_view_model.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {

  SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final SplashViewModel splashViewMode = SplashViewModel();

  @override
  void initState() {
    // TODO: implement initState
    splashViewMode.splashTime(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      body: Center(
        child: (Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
            Icons.check_circle_outline,
            size: 100,
            color: MyColors.midLightgrayColor,
                      ),
            MyText(title: "Attendnace Managment System",fontSize: 16,fontWeight: FontWeight.w500,)
          ],
        )),
      ),
    );
  }
}
