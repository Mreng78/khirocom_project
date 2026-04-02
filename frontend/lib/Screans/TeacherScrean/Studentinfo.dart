import 'package:flutter/material.dart';
import 'package:frontend/Widgets/AppColors.dart';
import 'package:frontend/models/Student.model.dart';


class Studentinfo extends StatelessWidget {
  final Student student;
  const Studentinfo({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("معلومات الطالب",style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          fontFamily: 'Cairo',
        ),  ),
        backgroundColor: Appcolors.appBarbackground,
      ),
      body: Center(
        child: Text(student.Name),
      ),
    );
  }
}
