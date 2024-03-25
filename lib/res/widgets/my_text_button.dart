import 'package:attendancemanagementsystem/res/my_colors/my_colors.dart';
import 'package:attendancemanagementsystem/res/widgets/my_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  final String title;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final bool loading;
  // final BorderRadius borderRadius;

  const MyTextButton({
    super.key,
    required this.title,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    required this.onPressed,
    this.backgroundColor,
    this.width,
    this.height,
    this.loading = false,
    // this.borderRadius = BorderRadius.circular(10),
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8)
        ),
        child: loading ? CircularProgressIndicator(color: MyColors.blackColor,) : MyText(
          title: title,
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: textColor,
        ),
      ),
    );
  }
}


