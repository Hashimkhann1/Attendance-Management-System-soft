
import 'dart:typed_data';

import 'package:attendancemanagementsystem/view_model/attendance_view_model/attendance_graph_View_model/attendance_graph_View_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ReportViewModel {
  final AttendanceGraphViewModel attendanceGraphViewModel =
  Get.put(AttendanceGraphViewModel());

  Future<Uint8List> generateDocument(
      BuildContext context, PdfPageFormat format) async {
    final doc = pw.Document(pageMode: PdfPageMode.outlines);

    List<pw.Widget> reportWidgets = [];

    reportWidgets.add(
      pw.Row(
        children: [
          pw.Text('Student attendance Report',
              style: pw.TextStyle(
                fontSize: 28,
                fontWeight: pw.FontWeight.bold
              )),
          pw.SizedBox(height: 60),
        ]
      )
    );

    // Add total attendance, total present, and total leave widgets
    reportWidgets.addAll([
      pw.Row(children: [
        pw.Text('Total attendance',
            style: pw.TextStyle(
              fontSize: 26,
            )),
        pw.SizedBox(width: 12),
        pw.Text(attendanceGraphViewModel.totalAttendance.toString(),
            style: pw.TextStyle(
              fontSize: 30,
            )),
      ]),
      pw.Row(children: [
        pw.Text('Total present',
            style: pw.TextStyle(
              fontSize: 26,
            )),
        pw.SizedBox(width: 12),
        pw.Text(attendanceGraphViewModel.totalPresent.toString(),
            style: pw.TextStyle(
              fontSize: 30,
            )),
      ]),
      pw.Row(children: [
        pw.Text('Total leave',
            style: pw.TextStyle(
              fontSize: 26,
            )),
        pw.SizedBox(width: 12),
        pw.Text(attendanceGraphViewModel.totalLeave.toString(),
            style: pw.TextStyle(
              fontSize: 30,
            )),
      ]),
      pw.SizedBox(height: 24),
    ]);

    // Add widgets for each attendance record
    for (int i = 0; i < attendanceGraphViewModel.allAttendanceForRepot.length; i++) {
      // print(attendanceGraphViewModel.allAttendanceDates.length);
      // print(attendanceGraphViewModel.allAttendanceForRepot[i][attendanceGraphViewModel.allAttendanceDates[i]]);
      reportWidgets.add(
        pw.Container(
            decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black, // Border color
                  width: 1, // Border width
                )),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
            children: [
              pw.Text(attendanceGraphViewModel.allAttendanceDates[i].toString(),style: pw.TextStyle(
                fontSize: 25,
              )),
              pw.SizedBox(width: 22),
              pw.Text(attendanceGraphViewModel.allAttendanceForRepot[i][attendanceGraphViewModel.allAttendanceDates[i]].toString(),style: pw.TextStyle(
                fontSize: 25,
              )),
            ],
          )
        )
      );
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
}
