import 'package:flutter/material.dart';
import 'package:frontend/Widgets/AppColors.dart';
import 'package:get/get.dart';
import 'package:frontend/Services/DailyProgressservice.dart';
import 'package:frontend/models/DailyProgress.model.dart';

class Dailyprogresscontroller extends GetxController {
  final RxList<DailyProgress> dailyProgress = <DailyProgress>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errormessage = "".obs;
  final RxString attendance = "حاضر".obs;
  final RxString dayName = "".obs;
  final RxString month = "".obs;
  final RxString year = "".obs;

  // Form Controllers
  final TextEditingController attendanceController = TextEditingController();
  final TextEditingController memorizationSorahController = TextEditingController();
  final TextEditingController memorizationAyahController = TextEditingController();
  final TextEditingController revisionSorahController = TextEditingController();
  final TextEditingController revisionAyahController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController dayNameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  // Reactive Levels
  final RxString memorizationLevel = "ــ".obs;
  final RxString revisionLevel = "ــ".obs;
  
  void setdayname(String dayName) {
    this.dayName.value = dayName;
  }
  void setmonth(String month) {
    this.month.value = month;
  }
  void setyear(String year) {
    this.year.value = year;
  }

  @override
  void onClose() {
    attendance.value = "حاضر";
    memorizationSorahController.dispose();
    memorizationAyahController.dispose();
    revisionSorahController.dispose();
    revisionAyahController.dispose();
    notesController.dispose();
    dayNameController.dispose();
    dateController.dispose();
    monthController.dispose();
    yearController.dispose();
    super.onClose();
  }

  void setAttendance(String attendance) {
    this.attendance.value = attendance;
  }

  Future<bool> adddailyprogress(Map<String, dynamic> dailyProgressdata) async {
    isLoading.value = true;
    errormessage.value = "";
    try {
      final result = await Dailyprogressservice.adddailyprogress(dailyProgressdata);
      if (result["success"] == true) {
        final newProgress = DailyProgress.fromJson(result["data"]);
        dailyProgress.add(newProgress);
        isLoading.value = false;
        
        // Wrap success UI logic in a delay to avoid overlay conflicts
        Future.delayed(Duration.zero, () {
          // Close dialog first
          if (Get.isDialogOpen ?? false) {
            Get.back();
          }

          // Clear fields on success
          memorizationSorahController.clear();
          memorizationAyahController.clear();
          revisionSorahController.clear();
          revisionAyahController.clear();
          notesController.clear();
          memorizationLevel.value = "ــ";
          revisionLevel.value = "ــ";

          Get.snackbar(
            "نجاح",
            "تمت إضافة التقدم اليومي بنجاح",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Appcolors.appmaincolor,
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
          );
        });
        
        return true;
      } else {
        Get.snackbar(
          "خطأ",
          result["message"] ?? "فشل إضافة التقدم اليومي",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        isLoading.value = false;
        return false;
      }
    } catch (e) {
      Get.snackbar(
        "خطأ",
        "فشل إضافة التقدم اليومي: $e",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      isLoading.value = false;
      return false;
    }
  }
}