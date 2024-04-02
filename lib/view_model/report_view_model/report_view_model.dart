import 'dart:typed_data';

import 'package:attendancemanagementsystem/res/constant/constant.dart';
import 'package:attendancemanagementsystem/res/my_colors/my_colors.dart';
import 'package:attendancemanagementsystem/res/widgets/my_text_button.dart';
import 'package:attendancemanagementsystem/view/admin_view/create_report_view/create_report_view.dart';
import 'package:attendancemanagementsystem/view/admin_view/create_report_view/specific_report_view/create_specific_report_view.dart';
import 'package:attendancemanagementsystem/view/admin_view/create_report_view/specific_report_view/specific_report_date_selection_view.dart';
import 'package:attendancemanagementsystem/view_model/attendance_view_model/attendance_graph_View_model/attendance_graph_View_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ReportViewModel {
  final AttendanceGraphViewModel attendanceGraphViewModel =
      Get.put(AttendanceGraphViewModel());

  /////// pdf file for all attendance report ////////
  Future<Uint8List> generateDocument(
      BuildContext context, PdfPageFormat format , String studentName) async {
    final doc = pw.Document(pageMode: PdfPageMode.outlines);

    List<pw.Widget> reportWidgets = [];

    reportWidgets.add(pw.Row(children: [
      pw.Text('Student attendance Report',
          style: pw.TextStyle(fontSize: 28, fontWeight: pw.FontWeight.bold)),
      pw.SizedBox(height: 60),
    ]));


    reportWidgets.add(pw.Row(children: [
      pw.SizedBox(height: 20),
      pw.Text('Student Name : ',
          style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
      pw.SizedBox(height: 16),
    pw.Text(studentName,
    style: pw.TextStyle(fontSize: 28, fontWeight: pw.FontWeight.bold)),
    ]));

    // Add total attendance, total present, and total leave widgets
    reportWidgets.addAll([
      pw.Row(children: [
        pw.Text('Total attendance',
            style: const pw.TextStyle(
              fontSize: 26,
            )),
        pw.SizedBox(width: 12),
        pw.Text(attendanceGraphViewModel.totalAttendance.toString(),
            style: const pw.TextStyle(
              fontSize: 30,
            )),
      ]),
      pw.Row(children: [
        pw.Text('Total present',
            style: const pw.TextStyle(
              fontSize: 26,
            )),
        pw.SizedBox(width: 12),
        pw.Text(attendanceGraphViewModel.totalPresent.value.toString(),
            style: const pw.TextStyle(
              fontSize: 30,
            )),
      ]),
      pw.Row(children: [
        pw.Text('Total leave',
            style: const pw.TextStyle(
              fontSize: 26,
            )),
        pw.SizedBox(width: 12),
        pw.Text(attendanceGraphViewModel.totalLeave.toString(),
            style: const pw.TextStyle(
              fontSize: 30,
            )),
      ]),
      pw.SizedBox(height: 24),
    ]);

    // Add widgets for each attendance record
    for (int i = 0;
        i < attendanceGraphViewModel.allAttendanceForRepot.length;
        i++) {
      // print(attendanceGraphViewModel.allAttendanceDates.length);
      // print(attendanceGraphViewModel.allAttendanceForReport[i][attendanceGraphViewModel.allAttendanceDates[i]]);
      reportWidgets.add(pw.Container(
          decoration: pw.BoxDecoration(
              border: pw.Border.all(
            color: PdfColors.black, // Border color
            width: 1, // Border width
          )),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
            children: [
              pw.Text(attendanceGraphViewModel.allAttendanceDates[i].toString(),
                  style: const pw.TextStyle(
                    fontSize: 25,
                  )),
              pw.SizedBox(width: 22),
              pw.Text(
                  attendanceGraphViewModel.allAttendanceForRepot[i]
                          [attendanceGraphViewModel.allAttendanceDates[i]]
                      .toString(),
                  style: const pw.TextStyle(
                    fontSize: 25,
                  )),
            ],
          )));
    }

    // Add all report widgets to the document
    doc.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            children: reportWidgets,
          );
        },
      ),
    );

    return doc.save();
  }


  List specificReportList = [];
  int totalSpecificAttendance = 0;
  int totalPresent = 0;
  int totalLeave = 0;

  void checkDatesForSpecificAttendance(BuildContext context,String studentName) {


    List<String> firstDateParts = attendanceGraphViewModel.selectedDatesForSpecificReport[0].toString().split('-');
    List<String> secondDateParts = attendanceGraphViewModel.selectedDatesForSpecificReport[1].toString().split('-');

    totalSpecificAttendance = 0;
    totalPresent = 0;
    totalLeave = 0;


    if(int.parse(firstDateParts[1]) <= int.parse(secondDateParts[1]) ){

      if(int.parse(firstDateParts[1]) == int.parse(secondDateParts[1])){
        print(firstDateParts);
        print(secondDateParts);



          if(int.parse(firstDateParts[0]) < int.parse(secondDateParts[0])){

            for(int i = 0; i < attendanceGraphViewModel.allAttendanceDates.length; i++){
              List<String> datesSpliting = attendanceGraphViewModel.allAttendanceDates[i].toString().split('-');

            if(int.parse(datesSpliting[0]) >= int.parse(firstDateParts[0]) && int.parse(firstDateParts[1]) == int.parse(datesSpliting[1]) ){
              if(int.parse(datesSpliting[0]) <= int.parse(secondDateParts[0])){
                specificReportList.add(attendanceGraphViewModel.allAttendanceDates[i]);
              }
            }
          }
        }else{
            if(kDebugMode){
              print("Swiping the dates");
            }
            List<String> swipeDate = attendanceGraphViewModel.selectedDatesForSpecificReport[0].toString().split('-');
            firstDateParts = secondDateParts;
            secondDateParts = swipeDate;


            for(int i = 0; i < attendanceGraphViewModel.allAttendanceDates.length; i++){
              List<String> datesSpliting = attendanceGraphViewModel.allAttendanceDates[i].toString().split('-');

              if(int.parse(datesSpliting[0]) >= int.parse(firstDateParts[0]) && int.parse(firstDateParts[1]) == int.parse(datesSpliting[1]) ){
                if(int.parse(datesSpliting[0]) <= int.parse(secondDateParts[0])){
                  specificReportList.add(attendanceGraphViewModel.allAttendanceDates[i]);
                }
              }
            }

          }

      }else{
        if(kDebugMode){
          print('show the pdf');
        }
        for(int i = 0; i < attendanceGraphViewModel.allAttendanceDates.length; i++){
          List<String> datesSpliting = attendanceGraphViewModel.allAttendanceDates[i].toString().split('-');

          if(int.parse(datesSpliting[0]) >=  int.parse(firstDateParts[0]) || (int.parse(datesSpliting[0]) <= int.parse(secondDateParts[0]) && int.parse(datesSpliting[1]) >  int.parse(firstDateParts[1])) ){
            specificReportList.add(attendanceGraphViewModel.allAttendanceDates[i]);
          }

        }
      }


      /////////////////////////////////////////////////////////////////////////////
      /////// this loop is runing for counting total presents and leaves ///////////
      /////////////////////////////////////////////////////////////////////////////
      for(int i = 0; i < specificReportList.length; i++){
        for(int a = 0; a < attendanceGraphViewModel.allAttendanceForRepot.length; a++){
          Map<String, dynamic> attendanceMap = attendanceGraphViewModel.allAttendanceForRepot[a];

          if(specificReportList[i] == attendanceMap.keys.first){
            if(attendanceMap.values.first == 'present'){
              totalPresent +=1;
            }
            else{
              totalLeave +=1;
            }
            // print('${attendanceMap.keys.first} ...... ${attendanceMap.values.first}');
          }
        }
      }

      totalSpecificAttendance += specificReportList.length;
      Navigator.pop(context);
      attendanceGraphViewModel.selectedDatesForSpecificReport.clear();
      Navigator.push(context, MaterialPageRoute(builder: (context) => CreateSpecificReportView(totalSpecificAttendance: totalSpecificAttendance,totalPresent: totalPresent,totalLeave: totalLeave,specificReportList: specificReportList,studentName: studentName.toString(),)));



    }else{
      Constant().toastMessage("Please select from the lowest date to the highest date.");
    }

  }

  /////// pdf file for specific attendance report ////////
  Future<Uint8List> generateDocumentForSpecificReport(BuildContext context, PdfPageFormat format , totalSpecificAttendance , totalPresent , totalLeave , List specitcReportDates , String studentName) async {

    final doc = pw.Document(pageMode: PdfPageMode.outlines);

    List<pw.Widget> reportWidgets = [];

    reportWidgets.add(pw.Row(children: [
      pw.Text('Student Specific attendance Report',
          style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
      pw.SizedBox(height: 60),
    ]));

    // reportWidgets.add(pw.Row(children: [
    //   pw.SizedBox(height: 20),
    //   pw.Text('Student Name : ',
    //       style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
    //   pw.SizedBox(height: 16),
    //   pw.Text(studentName,
    //       style: pw.TextStyle(fontSize: 28, fontWeight: pw.FontWeight.bold)),
    // ]));

    // Add total attendance, total present, and total leave widgets
    reportWidgets.addAll([
      pw.Row(children: [
        pw.Text('Total attendance',
            style: const pw.TextStyle(
              fontSize: 26,
            )),
        pw.SizedBox(width: 12),
        pw.Text(totalSpecificAttendance.toString(),
            style: const pw.TextStyle(
              fontSize: 30,
            )),
      ]),
      pw.Row(children: [
        pw.Text('Total present',
            style: const pw.TextStyle(
              fontSize: 26,
            )),
        pw.SizedBox(width: 12),
        pw.Text(totalPresent.toString(),
            style: const pw.TextStyle(
              fontSize: 30,
            )),
      ]),
      pw.Row(children: [
        pw.Text('Total leave',
            style: const pw.TextStyle(
              fontSize: 26,
            )),
        pw.SizedBox(width: 12),
        pw.Text(totalLeave.toString(),
            style: const pw.TextStyle(
              fontSize: 30,
            )),
      ]),
      pw.SizedBox(height: 24),
    ]);

    // Add widgets for each attendance record
    for(int i = 0; i < specitcReportDates.length; i++){
      for (int a = 0; a < attendanceGraphViewModel.allAttendanceForRepot.length; a++) {
        Map<String, dynamic> attendanceMap = attendanceGraphViewModel.allAttendanceForRepot[a];

        if(specitcReportDates[i] == attendanceMap.keys.first){
          reportWidgets.add(pw.Container(
              decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: PdfColors.black, // Border color
                    width: 1, // Border width
                  )),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                children: [
                  pw.Text(attendanceMap.keys.first.toString(),
                      style: const pw.TextStyle(
                        fontSize: 25,
                      )),
                  pw.SizedBox(width: 22),
                  pw.Text(attendanceMap.values.first.toString(),
                      style: const pw.TextStyle(
                        fontSize: 25,
                      )),
                ],
              )));
        }

      }
    }

    // Add all report widgets to the document
    doc.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            children: reportWidgets,
          );
        },
      ),
    );

    return doc.save();
  }



  ////////// bottomsheet for buttons ////////////
  void showBottomSheetForButtons(BuildContext context , String studentName) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        // Provide a builder function
        final width = MediaQuery.of(context).size.width;
        final height = MediaQuery.of(context).size.height;
        return Container(
          height: height * 0.24,
          decoration: const BoxDecoration(
              color: MyColors.whiteColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.04,
                width: width,
              ),
              MyTextButton(
                title: "Create complete report",
                textColor: MyColors.whiteColor,
                fontSize: 17,
                fontWeight: FontWeight.bold,
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CreateReportView(studentName: studentName,)));
                },
                backgroundColor: MyColors.lightBlackColor,
                width: width * 0.56,
                height: height * 0.06,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              MyTextButton(
                title: "Create specific report",
                textColor: MyColors.whiteColor,
                fontSize: 17,
                fontWeight: FontWeight.bold,
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SpecificReportDateSelectionView()));
                },
                backgroundColor: MyColors.lightBlackColor,
                width: width * 0.56,
                height: height * 0.06,
              ),
            ],
          ),
        );
      },
    );
  }

}
