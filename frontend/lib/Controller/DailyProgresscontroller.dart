import 'package:flutter/material.dart';
import 'package:frontend/Widgets/AppColors.dart';
import 'package:get/get.dart';
import 'package:frontend/Services/DailyProgressservice.dart';
import 'package:frontend/models/DailyProgress.model.dart';
import 'package:intl/intl.dart' as intl;

class Dailyprogresscontroller extends GetxController {
  final RxList<DailyProgress> dailyProgress = <DailyProgress>[].obs;
  final RxList<DailyProgress> studentHistory = <DailyProgress>[].obs;
  final RxList<String> monthyearnames = <String>[].obs;
  final RxList<DailyProgress> monthyearhistory = <DailyProgress>[].obs;
  final RxString selectedMonthYear = "".obs;
  final RxBool isLoading = false.obs;
  final RxString errormessage = "".obs;
  final RxInt lastFetchedStudentId = 0.obs;
  final RxString attendance = "حاضر".obs;
  final RxString dayName = "".obs;
  final RxString month = "".obs;
  final RxString year = "".obs;

  @override
  void onInit() {
    super.onInit();
    _initializeDates();
  }

  void _initializeDates() {
    DateTime now = DateTime.now();
    
    // Initialize Rx values
    dayName.value = intl.DateFormat('EEEE', 'ar').format(now);
    month.value = intl.DateFormat('MMMM', 'ar').format(now);
    year.value = intl.DateFormat('yyyy', 'en').format(now);

    // Initialize Controllers
    dateController.text = intl.DateFormat('yyyy-MM-dd').format(now);
    dayNameController.text = dayName.value;
    monthController.text = month.value;
    yearController.text = year.value;
  }
  Future<void> fetchDailyProgressByStudentId(int studentId) async {
    isLoading.value = true;
    errormessage.value = "";
    try {
      final result = await Dailyprogressservice.getdailyprogressbystudentid(studentId);
      if (result["success"] == true) {
        final List<dynamic> data = result["data"];
        studentHistory.value = data.map((json) => DailyProgress.fromJson(json)).toList();
      } else {
        errormessage.value = result["message"] ?? "فشل جلب سجل التقدم";
      }
    } catch (e) {
      errormessage.value = "خطأ في جلب البيانات: $e";
    } finally {
      isLoading.value = false;
    }
  }

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
  final RxString memorizationLevel = "-".obs;
  final RxString revisionLevel = "-".obs;
  
  void setdayname(String dayName) {
    this.dayName.value = dayName;
    dayNameController.text = dayName;
  }
  void setmonth(String month) {
    this.month.value = month;
    monthController.text = month;
  }
  void setyear(String year) {
    this.year.value = year;
    yearController.text = year;
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
  
  String cleanNumericInput(String input) {
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    String output = input;
    for (int i = 0; i < arabic.length; i++) {
      output = output.replaceAll(arabic[i], english[i]);
    }
    return output;
  }

  void setAttendance(String attendance) {
    this.attendance.value = attendance;
  }

  Future<bool> adddailyprogress(Map<String, dynamic> dailyProgressdata) async {
    isLoading.value = true;
    errormessage.value = "";
    
    // Clean numeric fields before sending
    if (dailyProgressdata.containsKey("year")) {
      dailyProgressdata["year"] = cleanNumericInput(dailyProgressdata["year"].toString());
    }
    if (dailyProgressdata.containsKey("Memorization_Progress_Ayah")) {
       dailyProgressdata["Memorization_Progress_Ayah"] = int.tryParse(cleanNumericInput(dailyProgressdata["Memorization_Progress_Ayah"].toString())) ?? 0;
    }
    if (dailyProgressdata.containsKey("Revision_Progress_Ayah")) {
       dailyProgressdata["Revision_Progress_Ayah"] = int.tryParse(cleanNumericInput(dailyProgressdata["Revision_Progress_Ayah"].toString())) ?? 0;
    }

    try {
      final result = await Dailyprogressservice.adddailyprogress(dailyProgressdata);
      if (result["success"] == true) {
        final newProgress = DailyProgress.fromJson(result["data"]);
        dailyProgress.add(newProgress);
        
        // Clear history cache to force refresh
        monthyearnames.clear();
        monthyearhistory.clear();
        selectedMonthYear.value = "";
        
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
        print(result["message"]);
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
  Future<bool> fetchMonthYearNames(int studentId) async {
    try {
      if (lastFetchedStudentId.value != studentId) {
        monthyearnames.clear();
        monthyearhistory.clear();
        selectedMonthYear.value = "";
        lastFetchedStudentId.value = studentId;
      }
      final result = await Dailyprogressservice.getallmonthyearnames(studentId);
      if (result["success"] == true) {
        final List<dynamic> data = result["data"];
        monthyearnames.value = data
            .map((e) => e["Month_year"]?.toString())
            .where((e) => e != null)
            .cast<String>()
            .toList();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
  Future<bool> fetchHistory(int studentId,String monthyear) async {
    isLoading.value = true;
    errormessage.value = "";
    try {
      final result = await Dailyprogressservice.getallmonthyearhistory(studentId,monthyear);
      if (result["success"] == true) {
        final List<dynamic> data = result["data"];
        monthyearhistory.value = data.map((json) => DailyProgress.fromJson(json)).toList();
        isLoading.value = false;
        return true;
      } else {  
        isLoading.value = false;
        return false;
      }
    } catch (e) {
      isLoading.value = false;
      return false;
    }
  }

}