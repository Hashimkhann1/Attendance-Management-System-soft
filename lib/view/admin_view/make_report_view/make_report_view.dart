import 'package:attendancemanagementsystem/view_model/report_view_model/report_view_model.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';


class MakeReportView extends StatelessWidget {
  MakeReportView({super.key});

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

      build: (format) => reportViewModel.generateDocument(
        context, format,
      ),
    );
  }
}
