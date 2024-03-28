import 'package:attendancemanagementsystem/res/my_colors/my_colors.dart';
import 'package:attendancemanagementsystem/res/widgets/my_text.dart';
import 'package:attendancemanagementsystem/view/admin_view/check_student_attendance_view/check_student_attendance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AllStudentsView extends StatelessWidget {
  AllStudentsView({super.key});

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: MyColors.blackColor,
      appBar: AppBar(
        title: MyText(
          title: "All Students",
          color: MyColors.whiteColor,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.blackColor,
        shadowColor: MyColors.whiteColor,
        elevation: 14,
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          SystemNavigator.pop();
        },
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context , snapshot) {
            if(snapshot.hasError){
              return Center(child: CircularProgressIndicator(color: Colors.red,));
            }else if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(color: MyColors.whiteColor,));
            }
            return Column(
              children: [
                SizedBox(
                  height: height * 0.04,
                ),

                //////////// Student name card //////////
                Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CheckStudentAttendanceView(studentId: snapshot.data!.docs[index].id.toString(),)));
                          },
                          child: snapshot.data!.docs[index]['userEmail'].toString() == _auth.currentUser!.email.toString() ? SizedBox() : Container(
                            width: width,
                            margin: EdgeInsets.symmetric(vertical: 5),
                            padding: EdgeInsets.symmetric(horizontal: 6,vertical: 10),
                            decoration: BoxDecoration(
                                color: MyColors.lightBlackColor,
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.school,color: MyColors.whiteColor,size: 44,),
                                SizedBox(width: width * 0.05,),
                                MyText(title: snapshot.data!.docs[index]['userName'].toString(),color: MyColors.whiteColor,fontWeight: FontWeight.bold,fontSize: 20,)
                              ],
                            ),
                          ),
                        );
                      }
                  ),
                )
              ],
            );

        },)
      ),
    );
  }
}
