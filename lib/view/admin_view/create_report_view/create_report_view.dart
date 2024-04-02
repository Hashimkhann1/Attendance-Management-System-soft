import 'package:attendancemanagementsystem/view_model/getx/logedIn_user_data_getx/logedIn_user_data.dart';
import 'package:attendancemanagementsystem/view_model/report_view_model/report_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';


class CreateReportView extends StatelessWidget {
  final String? studentName;
  CreateReportView({super.key , this.studentName});

  final ReportViewModel reportViewModel = ReportViewModel();
  final LogedInUserDataGetx logedInUserDataGetx = Get.put(LogedInUserDataGetx());

  @override
  Widget build(BuildContext context) {
    return PdfPreview(
      // maxPageWidth: 1000,
      // useActions: false,
      // canChangePageFormat: true,
      canChangeOrientation: false,
      // pageFormats:pageformat,
      canDebug: false,

      build: (format) => reportViewModel.generateDocument(
        context, format, studentName.toString()
      ),
    );
  }
}
