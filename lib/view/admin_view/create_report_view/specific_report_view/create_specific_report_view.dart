import 'package:attendancemanagementsystem/view_model/report_view_model/report_view_model.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';


class CreateSpecificReportView extends StatelessWidget {
  final int totalPresent;
  final int totalLeave;
  final int totalSpecificAttendance;
  final List specificReportList;
  CreateSpecificReportView({super.key,required this.totalSpecificAttendance,required this.totalPresent , required this.totalLeave,required this.specificReportList});

  final ReportViewModel reportViewModel = ReportViewModel();

  @override
  Widget build(BuildContext context) {

    return PdfPreview(
      // maxPageWidth: 1000,
      // useActions: false,
      // canChangePageFormat: true,
      canChangeOrientation: false,
      // pageFormats:pageformat,
      canDebug: false,

      build: (format) => reportViewModel.generateDocumentForSpecificReport(
        context, format,totalSpecificAttendance , totalPresent , totalLeave , specificReportList
      ),
    );;
  }
}
