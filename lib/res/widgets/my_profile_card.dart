import 'package:attendancemanagementsystem/res/my_colors/my_colors.dart';
import 'package:attendancemanagementsystem/res/widgets/my_text.dart';
import 'package:flutter/material.dart';

class MyProfileCard extends StatelessWidget {

  final String title;
  final IconData icon;

  const MyProfileCard({super.key,required this.title,this.icon = Icons.person});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 26,vertical: 8),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: MyColors.lightBlackColor,
          borderRadius: BorderRadius.circular(25)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon,color: MyColors.whiteColor,),
          SizedBox(width: width * 0.02,),
          MyText(title: title,color: MyColors.whiteColor,fontSize: 17,fontWeight: FontWeight.w600,),
        ],
      ),
    );
  }
}
