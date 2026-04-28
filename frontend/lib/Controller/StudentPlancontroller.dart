
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as intl;
import 'package:frontend/Widgets/AppColors.dart';
import 'package:frontend/models/StudentPlane.model.dart';
import 'package:get/get.dart';
import 'package:frontend/Services/studentpalanservice.dart';
import 'package:frontend/models/Quran.Model .dart';
import 'package:frontend/models/Aya.model.dart';
import 'package:frontend/Controller/StudentController.dart';
import 'package:frontend/Controller/SurahController.dart';
class StudentPlanController extends GetxController {

  // ───────────────── Controllers ─────────────────
  final startMemorizationSurahController = TextEditingController();
  final startMemorizationVerseController = TextEditingController();
  final dailyMemorizationAmountController = TextEditingController();
  final daysController = TextEditingController();
  final memorizationDaysController = TextEditingController();
  final revisionDaysController = TextEditingController();

  final startdatecontroller = TextEditingController();
  final enddatecontroller = TextEditingController();

  // ───────────────── Dependencies ─────────────────
  final studentController = Get.find<StudentController>();
  final surahController = Get.find<SurahController>();

  // ───────────────── Quran Data ─────────────────
  final Rxn<QuranModel> quran = Rxn<QuranModel>();

  // ───────────────── Reactive Values ─────────────────
  final RxInt startMemorizationSurah = 114.obs; // رقم السورة
  final RxInt startMemorizationVerse = 1.obs;
  final RxInt Currentpage =1.obs;
  final RxString dailyMemorizationAmount = "1".obs;
  final RxString memorizationDays = "20".obs;
  final RxString revisionDays = "20".obs;
  final RxInt totalPeriodDays = 0.obs;
  final RxString days = "20".obs; // Keeping for backward compatibility or general use
  final RxBool isLoading = false.obs;
  final RxString errormessage = "".obs;
  final RxInt startRevisionSurah = 114.obs;
  final RxInt startRevisionVerse = 1.obs;
  final RxInt CurrentRevisionPage = 1.obs;
  final RxString dailyRevisionAmount = "1".obs; // Store as Juz
  final RxString currentplanewindow = "addplan".obs;
  final RxList<StudentPlan> studentPlans = <StudentPlan>[].obs;
  final startRevisionSurahController = TextEditingController();
  final startRevisionVerseController = TextEditingController();
  final dailyRevisionAmountController = TextEditingController();
  final Rx<RevisionDirection> revisionDirection = RevisionDirection.forward.obs;


  final result = Rx<Ayah?>(null);
  final revisionResult = Rx<Ayah?>(null);
  final revisionCycles = 0.obs;
  
  final startday = "-".obs;
  final startmonth = "-".obs;
  final startyear = "-".obs;
  final endday = "-".obs;
  final endmonth = "-".obs;
  final endyear = "-".obs;



  void setcurrentplanewindow(String window) => currentplanewindow.value = window;

  void setstartday(String day) => startday.value = day;
  void setstartmonth(String month) => startmonth.value = month;
  void setstartyear(String year) => startyear.value = year;

  void setendday(String day) => endday.value = day;
  void setendmonth(String month) => endmonth.value = month;
  void setendyear(String year) => endyear.value = year;

  void setRevisionDirection(RevisionDirection direction) {
    revisionDirection.value = direction;
    getRevisionPlanTarget();
  }

  void getplanetarget() => getPlanTarget();

  String getmounthname() {
    return intl.DateFormat('MMMM', 'ar').format(DateTime.now());
  }

  String getyear() {
    return intl.DateFormat('yyyy', 'en').format(DateTime.now());
  }

  // ───────────────── Initialization ─────────────────
  @override
  void onInit() {
    super.onInit();
    
    // Initialize dates with defaults
    final now = DateTime.now();
    startdatecontroller.text = now.toString().split(' ')[0];
    enddatecontroller.text = now.add(const Duration(days: 30)).toString().split(' ')[0];
    daysController.text = "20";
    
    updateDaysFromDates();
    
    loadQuran();

    // 🔥 التحقق الفوري: إذا كان الطالب محدداً مسبقاً قبل دخول الشاشة
    if (studentController.selectedStudent.value != null) {
      loadInitialValues();
    }

    // 🔥 إذا تغيرت قيمة الطالب لاحقًا وأنت داخل الشاشة
    ever(studentController.selectedStudent, (student) {
      if (student != null) {
        loadInitialValues();
      }
    });

    setupAutoCalculation();
  }

  // ───────────────── تحميل القرآن ─────────────────
  Future<void> loadQuran() async {
    String data = await rootBundle.loadString('assets/files/quran.json');
    quran.value = QuranModel.fromJson(jsonDecode(data));
  }

  // ───────────────── تحميل بيانات الطالب ─────────────────
  void loadInitialValues() {
    final student = studentController.selectedStudent.value;

    if (student != null) {
      // Memorization
      int surahIndex = int.tryParse(student.current_Memorization_Sorah) ??
          surahController.getsurahindex(student.current_Memorization_Sorah);

      if (surahIndex == -1) surahIndex = 114;
      startMemorizationSurah.value = surahIndex;

      startMemorizationVerse.value =
          int.tryParse(student.current_Memorization_Aya) ?? 1;
      
      // تعبئة الحقول
      startMemorizationSurahController.text =
          surahController.getsurahname(surahIndex);
      startMemorizationVerseController.text =
          startMemorizationVerse.value.toString();
      
      // مقدار الحفظ الافتراضي (إذا لم يكن هناك قيمة سابقة، نفترض 1)
      dailyMemorizationAmountController.text = "1";
      dailyMemorizationAmount.value = "1";

      // Revision
      int revisionSurahIndex = int.tryParse(student.current_Revision_Sorah) ??
          surahController.getsurahindex(student.current_Revision_Sorah);
      
      if (revisionSurahIndex == -1) revisionSurahIndex = 114;
      startRevisionSurah.value = revisionSurahIndex;
      startRevisionVerse.value =
          int.tryParse(student.current_Revision_Aya) ?? 1;

      startRevisionSurahController.text =
          surahController.getsurahname(revisionSurahIndex);
      startRevisionVerseController.text =
          startRevisionVerse.value.toString();
      
      // مقدار المراجعة الافتراضي (جزء واحد)
      dailyRevisionAmountController.text = "1";
      dailyRevisionAmount.value = "1";

      // تحديث الصفحات والحسابات فورية بمجرد توفر البيانات
      if (quran.value != null) {
        Currentpage.value = Ayah.getPage(
          quran.value,
          surahIndex,
          startMemorizationVerse.value,
        );
        CurrentRevisionPage.value = Ayah.getPage(
          quran.value,
          revisionSurahIndex,
          startRevisionVerse.value,
        );
        getPlanTarget();
        getRevisionPlanTarget();
      }
    }
  }

  void updateDaysFromDates() {
    try {
      DateTime? start = DateTime.tryParse(startdatecontroller.text);
      DateTime? end = DateTime.tryParse(enddatecontroller.text);

      if (start != null && end != null) {
        // Difference + 1 to include both start and end days
        int diff = end.difference(start).inDays + 1;
        if (diff < 1) diff = 1;
        
        totalPeriodDays.value = diff;
        
        // Default memorization and revision days to the total
        memorizationDays.value = diff.toString();
        revisionDays.value = diff.toString();
        days.value = diff.toString();

        memorizationDaysController.text = diff.toString();
        revisionDaysController.text = diff.toString();
      }
    } catch (e) {
      print("Error updating days: $e");
    }
  }

  // ───────────────── تحديث تلقائي ─────────────────
  void setupAutoCalculation() {
    everAll(<RxInterface>[
      quran,
      startMemorizationSurah,
      startMemorizationVerse,
      dailyMemorizationAmount,
      memorizationDays,
    ], (_) => getPlanTarget());

    everAll(<RxInterface>[
      quran,
      startRevisionSurah,
      startRevisionVerse,
      dailyRevisionAmount,
      revisionDays,
      revisionDirection,
    ], (_) => getRevisionPlanTarget());
  }

  // ───────────────── الحساب ─────────────────
  void getPlanTarget() {
    if (quran.value == null) return;

    try {
      int startSurah = startMemorizationSurah.value;
      int currentAya = startMemorizationVerse.value;

      // تحويل المقادير إلى أرقام عشرية لدعم الكسور
      double daily = double.tryParse(dailyMemorizationAmount.value) ?? 1.0;
      int totalDays = int.tryParse(memorizationDays.value) ?? 1;

      // تحديث رقم الصفحة الحالية
      Currentpage.value = Ayah.getPage(quran.value, startSurah, currentAya);

      print("CALC: s=$startSurah a=$currentAya d=$daily days=$totalDays");

      final planResult = Ayah.calculatePlanEnd(
        quran.value!,
        startSurah,
        currentAya,
        daily,
        totalDays,
      );
      result.value = planResult.target;
      print(studentController.selectedStudent.value?.current_Memorization_Sorah);

      print("RESULT: ${result.value?.surahName} - ${result.value?.verse}");

    } catch (e) {
      print("Error: $e");
      result.value = null;
    }
  }

  void getRevisionPlanTarget() {
    if (quran.value == null) return;

    try {
      int startSurah = startRevisionSurah.value;
      int currentAya = startRevisionVerse.value;

      double daily = double.tryParse(dailyRevisionAmount.value) ?? 1.0;
      int totalDays = int.tryParse(revisionDays.value) ?? 1;

      // تحديث رقم الصفحة الحالية للمراجعة
      CurrentRevisionPage.value =
          Ayah.getPage(quran.value, startSurah, currentAya);

      // الحد هو السورة التي قبل الحفظ الخاص به
      final double amountInPages = daily * 20.0;
      final double totalPagesToRevise = amountInPages * totalDays;
      print("CONTROLLER REVISION: AmountInJuz=$daily, AmountInPages=$amountInPages, Days=$totalDays, TotalPagesToRevise=$totalPagesToRevise");

      final student = studentController.selectedStudent.value;
      if (student == null) return;

      final currentMemSurah = int.tryParse(student.current_Memorization_Sorah) ??
          surahController.getsurahindex(student.current_Memorization_Sorah);
      final currentMemVerse = int.tryParse(student.current_Memorization_Aya) ?? 1;

      final planResult = Ayah.calculateRevision(
        quran: quran.value!,
        startSurah: startSurah,
        startVerse: currentAya,
        dailyAmount: daily,
        days: totalDays,
        direction: revisionDirection.value,
        currentMemorizationSurah: currentMemSurah,
        currentMemorizationVerse: currentMemVerse,
      );

      print("REVISION RESULT: ${planResult.target.surahName} (Page: ${planResult.target.page}) Cycles: ${planResult.cycles}");
      revisionResult.value = planResult.target;
      revisionCycles.value = planResult.cycles;
      print("REVISION RESULT: ${revisionResult.value?.surahName} (Page: ${revisionResult.value?.page}) Cycles: ${revisionCycles.value}");
    } catch (e) {
      print("Error in revision calculation: $e");
      revisionResult.value = null;
    }
  }

  // ───────────────── UI Bindings ─────────────────
  void onSurahChanged(String value) {
    int index = int.tryParse(value) ?? surahController.getsurahindex(value);
    startMemorizationSurah.value = index;
  }

  void onVerseChanged(String value) {
    startMemorizationVerse.value = int.tryParse(value) ?? 1;
  }

  void onDailyAmountChanged(String value) {
    if (value.isEmpty) {
      dailyMemorizationAmount.value = "1";
    } else {
      double? val = double.tryParse(value);
      dailyMemorizationAmount.value = val != null ? val.toString() : "1";
    }
  }

  void onDaysChanged(String value) {
    days.value = value.isNotEmpty ? value : "1";
  }

  void onRevisionSurahChanged(String value) {
    int index = int.tryParse(value) ?? surahController.getsurahindex(value);
    startRevisionSurah.value = index;
    print("REVISION SURAH CHANGED: $index");
  }

  void onRevisionVerseChanged(String value) {
    startRevisionVerse.value = int.tryParse(value) ?? 1;
    print("REVISION VERSE CHANGED: ${startRevisionVerse.value}");
  }

  void onDailyRevisionAmountChanged(String value) {
    if (value.isEmpty) {
      dailyRevisionAmount.value = "1";
    } else {
      double? val = double.tryParse(value);
      dailyRevisionAmount.value = val != null ? val.toString() : "1";
    }
    print(
      "REVISION AMOUNT CHANGED: ${dailyRevisionAmount.value} Juz",
    );
  }


  Future<bool> addstudentplan(Map<String, dynamic> studentplandata) async {
    isLoading.value = true;
    errormessage.value = "";
    try {
      final response = await StudentPlanService().addstudentplan(studentplandata);
      if (response["success"] == true) {
        final newPlan = StudentPlan.fromJson(response["data"]);
        studentPlans.add(newPlan);
        isLoading.value = false;
        
        Get.snackbar(
          "نجاح",
          "تمت إضافة الخطة بنجاح",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Appcolors.appmaincolor,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
        
        return true;
      } else {
        Get.snackbar(
          "خطأ",
          response["message"] ?? "فشل إضافة الخطة",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        isLoading.value = false;
        return false;
      }
    } catch (e) {
      print("Error in addstudentplan: $e");
      Get.snackbar(
        "خطأ",
        "فشل إضافة الخطة: $e",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      isLoading.value = false;
      return false;
    }
  }

  void saveCurrentPlan() {
    final m = result.value;
    final r = revisionResult.value;
    final student = studentController.selectedStudent.value;

    if (student == null) {
      Get.snackbar("تنبيه", "يرجى اختيار طالب أولاً", backgroundColor: Colors.orange);
      return;
    }

    if (m == null || r == null) {
      Get.snackbar("تنبيه", "يرجى الانتظار حتى اكتمال حساب الخطة", backgroundColor: Colors.orange);
      return;
    }

    try {
      final studentPlan = StudentPlan(
        Current_Memorization_Surah: surahController.getsurahname(startMemorizationSurah.value),
        Current_Memorization_Ayah: startMemorizationVerse.value,
        Daily_Memorization_Amount: double.tryParse(dailyMemorizationAmount.value) ?? 1.0,
        target_Memorization_Surah: m.surahName,
        target_Memorization_Ayah: m.verse,
        Daily_Revision_Amount: double.tryParse(dailyRevisionAmount.value) ?? 1.0, // Store as Juz
        Current_Revision: surahController.getsurahname(startRevisionSurah.value),
        target_Revision: r.surahName,
        StartsAt: DateTime.parse(startdatecontroller.text),
        EndsAt: DateTime.parse(enddatecontroller.text),
        Memorization_ItsDone: false,
        Revision_ItsDone: false,
        StudentId: student.Id,
        Month: getmounthname(),
        Year: getyear(),
        Is_Current_Month_Plan: true,
        Revision_Cycles: revisionCycles.value,
        CreatedDate: DateTime.now(),
        UpdatedDate: DateTime.now(),
      );

      addstudentplan(studentPlan.toJson());
    } catch (e) {
      Get.snackbar("خطأ", "بيانات المدخلات غير صالحة: $e", backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  // ───────────────── جلب خطط الطالب ─────────────────
  Future<void> getStudentPlans(int studentId) async {
    isLoading.value = true;
    errormessage.value = "";
    try {
      final response = await StudentPlanService().getStudentPlans(studentId);
      if (response["success"] == true) {
        // تحويل الـ List<dynamic> إلى List<StudentPlan>
        final List<dynamic> jsonList = response["data"];
        studentPlans.assignAll(
          jsonList.map((json) => StudentPlan.fromJson(json)).toList()
        );
        isLoading.value = false;
      } else {
        errormessage.value = response["message"] ?? "فشل جلب الخطط";
        Get.snackbar("خطأ", errormessage.value, backgroundColor: Colors.red, colorText: Colors.white);
        isLoading.value = false;
      }
    } catch (e) {
      print("Error in getStudentPlans: $e");
      errormessage.value = "خطأ في الاتصال بالسيرفر: $e";
      Get.snackbar("خطأ", errormessage.value, backgroundColor: Colors.red, colorText: Colors.white);
      isLoading.value = false;
    }
  }

  // ───────────────── حذف خطة ─────────────────
  Future<bool> deleteStudentPlan(int planId) async {
    try {
      final response = await StudentPlanService().deleteStudentPlan(planId);
      if (response["success"] == true) {
        // إزالة الخطة من القائمة
        studentPlans.removeWhere((plan) => plan.Id == planId);
        Get.snackbar("نجاح", "تم حذف الخطة بنجاح", backgroundColor: Colors.green, colorText: Colors.white);
        return true;
      } else {
        Get.snackbar("خطأ", response["message"] ?? "فشل حذف الخطة", backgroundColor: Colors.red, colorText: Colors.white);
        return false;
      }
    } catch (e) {
      print("Error in deleteStudentPlan: $e");
      Get.snackbar("خطأ", "فشل حذف الخطة: $e", backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
  }

  double calculateProgress(StudentPlan plan, {bool isRevision = false}) {
    if (quran.value == null) return 0.0;

    final student = studentController.selectedStudent.value;
    if (student == null) return 0.0;

    try {
      int startS, startV, targetS, targetV, currentS, currentV;

      if (isRevision) {
        startS = int.tryParse(plan.Current_Revision) ??
            surahController.getsurahindex(plan.Current_Revision);
        startV = 1;
        targetS = int.tryParse(plan.target_Revision) ??
            surahController.getsurahindex(plan.target_Revision);
        targetV = 1;
        currentS = int.tryParse(student.current_Revision_Sorah) ??
            surahController.getsurahindex(student.current_Revision_Sorah);
        currentV = int.tryParse(student.current_Revision_Aya) ?? 1;
      } else {
        startS = int.tryParse(plan.Current_Memorization_Surah) ??
            surahController.getsurahindex(plan.Current_Memorization_Surah);
        startV = plan.Current_Memorization_Ayah;
        targetS = int.tryParse(plan.target_Memorization_Surah) ??
            surahController.getsurahindex(plan.target_Memorization_Surah);
        targetV = plan.target_Memorization_Ayah;
        currentS = int.tryParse(student.current_Memorization_Sorah) ??
            surahController.getsurahindex(student.current_Memorization_Sorah);
        currentV = int.tryParse(student.current_Memorization_Aya) ?? 1;
      }

      int startPage = Ayah.getPage(quran.value, startS, startV);
      int targetPage = Ayah.getPage(quran.value, targetS, targetV);
      int currentPage = Ayah.getPage(quran.value, currentS, currentV);

      if (startPage == targetPage) return 100.0;

      int totalPages = (targetPage - startPage).abs();
      if (totalPages == 0) return 100.0;

      int completedPages = (currentPage - startPage).abs();
      double progress = (completedPages / totalPages) * 100;

      return progress.clamp(0.0, 100.0);
    } catch (e) {
      print("Error calculating progress: $e");
      return 0.0;
    }
  }
}