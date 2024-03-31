import 'package:attendancemanagementsystem/res/my_colors/my_colors.dart';
import 'package:attendancemanagementsystem/res/widgets/my_text.dart';
import 'package:attendancemanagementsystem/view/admin_view/leave_approval_view/leave_appoval_detail_view/leave_appoval_detail_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LeaveApprovalView extends StatelessWidget {
  LeaveApprovalView({super.key});

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: MyColors.blackColor,
      appBar: AppBar(
        title: MyText(
          title: "Leave approval",
          color: MyColors.whiteColor,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        backgroundColor: MyColors.blackColor,
        automaticallyImplyLeading: false,
        shadowColor: MyColors.whiteColor,
        elevation: 14,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(_auth.currentUser!.uid.toString())
            .collection('leaveApproval')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: MyColors.whiteColor,
              ),
            );
          } else if (snapShot.hasError) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }

          return ListView.builder(
              itemCount: snapShot.data!.docs.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Timestamp timestamp = snapShot.data!.docs[index]['date'];
                    DateTime dateTime = timestamp.toDate();
                    String approvalDate =
                        DateFormat("MMMM/d/yyyy 'at' h:mm:ss").format(dateTime);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LeaveApprovalDetailView(
                                  studentName: snapShot.data!.docs[index]
                                      ['studentName'],
                                  approvalStatus: snapShot.data!.docs[index]
                                      ['approvalStatus'],
                                  approvalDate: approvalDate,
                              approvalId: snapShot.data!.docs[index].id.toString(),
                              approvalReadOrUnReadStatus: snapShot.data!.docs[index]
                              ['approvalReadOrUnreadStatud'],
                            )));
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: height * 0.04),
                    decoration: BoxDecoration(
                        color: MyColors.lightBlackColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      title: MyText(
                        title: snapShot.data!.docs[index]['studentName'],
                        color: MyColors.whiteColor,
                        fontSize: 21,
                        fontWeight: FontWeight.w600,
                      ),
                      subtitle: MyText(
                        title: "Approval for leave",
                        color: MyColors.lightgrayColor,
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          snapShot.data!.docs[index]
                          ['approvalReadOrUnreadStatud'] == 'unRead' ? Container(
                            width: 20,
                            height: 16,
                            decoration: BoxDecoration(
                                color: Colors.red, shape: BoxShape.circle),
                          ) : SizedBox(),
                          Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: MyColors.whiteColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
