import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../models/Student.model.dart';
import '../Controller/StudentController.dart';

class StudentInfoScreenController extends GetxController {

  final StudentController studentController = Get.put(StudentController());
  final RxString selectedwindow = "البيانات".obs;
   
   final TextEditingController textfildnamecontroller = TextEditingController();
   final TextEditingController textfildagecontroller = TextEditingController();
   final TextEditingController textfildcatigorycontroller = TextEditingController();
   final TextEditingController textfildgendercontroller = TextEditingController();
   final TextEditingController textfildcurrent_memorization_sorahcontroller = TextEditingController();
   final TextEditingController textfildcurrent_memorization_ayacontroller = TextEditingController();
   final TextEditingController textfildphonenumbercontroller = TextEditingController();
   final TextEditingController textfildfathernumbercontroller = TextEditingController();
   final TextEditingController textfildusernamecontroller = TextEditingController();
   final TextEditingController textfildpasswordcontroller = TextEditingController();
   final TextEditingController textfildstatuscontroller = TextEditingController();
   final TextEditingController dismissreasonController = TextEditingController();
   final TextEditingController dismissdateController = TextEditingController();

   @override
   void onInit() {
    super.onInit();
    
    // Use worker to update fields whenever selectedStudent changes
    ever(studentController.selectedStudent, (student) {
      if (student != null) {
        populateFields(student);
      }
    });

    // Only populate if a student is already selected (e.g. on hot restart/reload if state is persisted)
    if (studentController.selectedStudent.value != null) {
      populateFields(studentController.selectedStudent.value!);
    }
   }

   void populateFields(Student student) {
    textfildnamecontroller.text = student.Name;
    textfildagecontroller.text = student.Age.toString();
    textfildcatigorycontroller.text = student.Category;
    textfildgendercontroller.text = student.Gender;
    textfildstatuscontroller.text = student.status;
    textfildcurrent_memorization_sorahcontroller.text = student.current_Memorization_Sorah;
    textfildcurrent_memorization_ayacontroller.text = student.current_Memorization_Aya;
    textfildphonenumbercontroller.text = student.phoneNumber;
    textfildfathernumbercontroller.text = student.FatherNumber;
    textfildusernamecontroller.text = student.Username;
    textfildpasswordcontroller.text = student.Password;
   }

   void changeWindow(String window){
    selectedwindow.value = window;
    if (window == "فصل" && dismissdateController.text.isEmpty) {
      dismissdateController.text = intl.DateFormat('yyyy-MM-dd').format(DateTime.now());
    }
   }
}