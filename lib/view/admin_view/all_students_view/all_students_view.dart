

import 'package:attendancemanagementsystem/res/widgets/my_text.dart';
import 'package:flutter/material.dart';

class AllStudentsView extends StatelessWidget {
  const AllStudentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MyText(title: "Welcom To all Students"),
        ],
      ),
    );
  }
}
