import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/Widgets/AppColors.dart';
import 'package:frontend/Widgets/CustomBottomNavBar.dart';
import 'package:frontend/Widgets/DropDown.dart';
import 'package:frontend/Widgets/appbarcontainer.dart';
import 'package:frontend/models/Student.model.dart';
import 'package:get/get.dart';
import 'package:frontend/Controller/Auth_controller.dart';
import 'package:frontend/Controller/StudentController.dart';
import 'package:frontend/Controller/StudentInfoScreenController.dart';
import 'package:frontend/Widgets/CustomTextField.dart';
import 'package:frontend/Controller/UploadsController.dart';
import 'package:frontend/models/surah_data.model.dart';
import 'package:frontend/Controller/SurahController.dart';
import 'package:intl/intl.dart' as intl;
import 'package:frontend/Controller/DailyProgresscontroller.dart';
import 'package:frontend/Controller/StudentPlancontroller.dart';
import 'package:frontend/models/DailyProgress.model.dart';
import 'package:frontend/models/StudentPlane.model.dart';
import 'package:frontend/models/Aya.model.dart';

class StudentInfoScreen extends StatelessWidget {
  StudentInfoScreen({super.key});
  //final AuthController authController = Get.put(AuthController());
  final StudentController studentController = Get.find();
  final Dailyprogresscontroller dailyprogresscontroller = Get.find();
  final AuthController authService = Get.find();
  final UploadsController uploadsController = Get.find();
  final StudentInfoScreenController studentInfoScreenController = Get.find();
  final SurahController surahController = Get.find();
  late final StudentPlanController studentPlanController =
      Get.isRegistered<StudentPlanController>()
      ? Get.find<StudentPlanController>()
      : Get.put(StudentPlanController());

  final List<String> attendanceOptions = const ["حاضر", "غائب", "مستأذن"];
  final List<String> levelOptions = const [
    "ضعيف",
    "مقبول",
    "جيد",
    "جيد جدا",
    "ممتاز",
    "-",
  ];
  final List<String> revisionlevelOptions = const [
    "ضعيف",
    "مقبول",
    "جيد",
    "جيد جدا",
    "ممتاز",
    "ــ",
  ];
  final List<String> daysOfWeek = const [
    "السبت",
    "الأحد",
    "الاثنين",
    "الثلاثاء",
    "الأربعاء",
    "الخميس",
    "الجمعة",
  ];
  final List<String> genderOptions = const ['ذكر', 'أنثى'];
  final List<String> categoryOptions = const [
    "اطفال",
    "أقل من 5 أجزاء",
    "5 أجزاء",
    "10 أجزاء",
    "15 جزء",
    "20 جزء",
    "25 جزء",
    "المصحف كامل",
  ];
  final List<String> statusOptions = const ["موقف", "مفصول", "مستمر"];
  final List<String> surahNames = SurahData.surahnames();
  final List<String> windows = const [
    "البيانات",
    "تعديل",
    "فصل",
    "الأداء اليومي",
    "الخطة",
    "السجل",
    "إيقاف",
    "نقل",
  ];
  String getdayname() {
    // initializeDateFormatting('ar', null);
    DateTime now = DateTime.now();
    return intl.DateFormat('EEEE', 'ar').format(now);
  }

  String getmounthname() {
    DateTime now = DateTime.now();
    return intl.DateFormat('MMMM', 'ar').format(now);
  }

  String getyear() {
    DateTime now = DateTime.now();
    return intl.DateFormat('yyyy', 'en').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // يخليه فوق المحتوى
        statusBarIconBrightness: Brightness.light, // لون الأيقونات
        statusBarBrightness: Brightness.dark, // iOS
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        // extendBody: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(150.0),
          child: Appbarcontainer(
            title: 'بيانات الطالب',
            undertitel: studentController.getshortname(),
            navigationwidget: Container(
              //margin: const EdgeInsets.only(bottom: 10),
              child: SizedBox(
                height: 35,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      _buildnavbaritems(icon: Icons.edit, windowname: "تعديل"),
                      _buildnavbaritems(icon: Icons.delete, windowname: "فصل"),
                      _buildnavbaritems(
                        icon: Icons.checklist_rtl,
                        windowname: "الخطة",
                      ),
                      _buildnavbaritems(
                        icon: Icons.info,
                        windowname: "البيانات",
                      ),
                      _buildnavbaritems(
                        icon: Icons.event_available,
                        windowname: "الأداء اليومي",
                      ),
                      _buildnavbaritems(
                        icon: Icons.swap_horiz,
                        windowname: "نقل",
                      ),
                      _buildnavbaritems(
                        icon: Icons.stop_circle_outlined,
                        windowname: "إيقاف",
                      ),
                      _buildnavbaritems(
                        icon: Icons.history,
                        windowname: "السجل",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/appbackground.jpg"),
              fit: BoxFit.cover,
              opacity: 0.5,
            ),
          ),

          child: Obx(() {
            final student = studentController.selectedStudent.value;
            return student != null
                ? Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      children: [
                        const SizedBox(height: 115),
                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                //padding: const EdgeInsets.all(15),
                                // margin: const EdgeInsets.symmetric(
                                //   horizontal: 10,
                                // ),
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  // borderRadius: const BorderRadius.all(
                                  //   Radius.circular(20),
                                  // ),
                                  // border: Border.all(
                                  //   color: Appcolors.appmaincolor,
                                  //   width: 2,
                                  // ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Obx(() {
                                  final studentData =
                                      studentController.selectedStudent.value;

                                  if (studentData == null) {
                                    return const Center(
                                      child: Text("لا توجد بيانات"),
                                    );
                                  }

                                  switch (studentInfoScreenController
                                      .selectedwindow
                                      .value) {
                                    case "البيانات":
                                      return _buildinfowindow(studentData);
                                    case "تعديل":
                                      return _buildeditwindow(
                                        studentData,
                                        context,
                                      );
                                    case "فصل":
                                      return _builddissmiswindow(
                                        context,
                                        studentData,
                                      );
                                    case 'الأداء اليومي':
                                      return _builddailyprograssWindow(context);
                                    case 'الخطة':
                                      return _studentplanwindow(context);
                                    case 'السجل':
                                      return _buildhistorywindow(studentData);
                                    default:
                                      return _buildUnderDevelopment();
                                  }
                                }),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        Custombottomnavbar(
                          centerbutton: 'Home',
                          currentpage: 'student_info',
                        ),
                      ],
                    ),
                  )
                : const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.school_outlined, size: 50),
                        SizedBox(height: 12),
                        Text(
                          "لم يتم تحديد طالب",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Tajawal',
                          ),
                        ),
                      ],
                    ),
                  );
          }),
        ),
      ),
    );
  }

  Widget _buildnavbaritems({
    required IconData icon,
    required String windowname,
  }) {
    return Obx(() {
      bool isSelected =
          studentInfoScreenController.selectedwindow.value == windowname;

      return GestureDetector(
        onTap: () {
          Future.microtask(() {
            studentInfoScreenController.changeWindow(windowname);
          });
        },
        child: AnimatedContainer(
          height: 30,
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.white.withOpacity(0.9)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.3),
                      blurRadius: 8,
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.black : Colors.white,
                size: 14,
              ),
              const SizedBox(width: 5),
              Text(
                windowname,
                style: TextStyle(
                  color: isSelected ? Colors.black : Colors.white,
                  fontSize: 12,
                  fontFamily: 'Tajawal',
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildUnderDevelopment() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.construction_rounded,
            size: 60,
            color: Appcolors.appmaincolor.withOpacity(0.4),
          ),
          const SizedBox(height: 16),
          Text(
            'تحت التطوير',
            style: TextStyle(
              color: Appcolors.appmaincolor,
              fontSize: 26,
              fontWeight: FontWeight.bold,
              fontFamily: 'Tajawal',
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildStudentInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                height: 46,
                width: 110,
                decoration: BoxDecoration(
                  color: Appcolors.appmaincolor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.25),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Appcolors.appmaincolor.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),

          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  height: 46,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Appcolors.appmaincolor.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      value.isNotEmpty ? value : '—',
                      style: TextStyle(
                        color: Appcolors.appmaincolor,
                        fontSize: 15,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildcliprect(String label) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          height: 46,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Appcolors.appmaincolor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.white.withOpacity(0.25),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Appcolors.appmaincolor.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }

  void _showUpdateDialog(BuildContext context, Student studentData) {
    Get.dialog(
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: AlertDialog(
          backgroundColor: Appcolors.appmaincolor.withOpacity(0.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(
              color: const Color.fromARGB(255, 7, 63, 9),
              width: 2,
            ),
          ),

          title: const Text(
            "تأكيد التعديل",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            "هل انت متاكد من تعديل بيانات الطالب؟",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w600,
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              child: const Text(
                "إلغاء",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              onPressed: studentController.isStudentsLoading.value
                  ? null
                  : () async {
                      Map<String, dynamic> updatedData = {
                        "Id": studentData.Id,
                        "Name": studentInfoScreenController
                            .textfildnamecontroller
                            .text,
                        "Age":
                            int.tryParse(
                              studentInfoScreenController
                                  .textfildagecontroller
                                  .text,
                            ) ??
                            studentData.Age,
                        "Category": studentInfoScreenController
                            .textfildcatigorycontroller
                            .text,
                        "Gender": studentInfoScreenController
                            .textfildgendercontroller
                            .text,
                        "status": studentInfoScreenController
                            .textfildstatuscontroller
                            .text,
                        "current_Memorization_Sorah":
                            studentInfoScreenController
                                .textfildcurrent_memorization_sorahcontroller
                                .text,
                        "current_Memorization_Aya": studentInfoScreenController
                            .textfildcurrent_memorization_ayacontroller
                            .text,
                        "phoneNumber": studentInfoScreenController
                            .textfildphonenumbercontroller
                            .text,
                        "FatherNumber": studentInfoScreenController
                            .textfildfathernumbercontroller
                            .text,
                        "Username": studentInfoScreenController
                            .textfildusernamecontroller
                            .text,
                        "Password": studentInfoScreenController
                            .textfildpasswordcontroller
                            .text,
                        "ImageUrl":
                            uploadsController.uploadedImageUrl.isNotEmpty
                            ? uploadsController.uploadedImageUrl.value
                            : studentData.ImageUrl,
                      };

                      bool success = await studentController.updateStudent(
                        studentData.Id,
                        updatedData,
                      );
                      if (success) {
                        uploadsController.uploadedImageUrl.value = "";
                        studentInfoScreenController.changeWindow("البيانات");
                      }
                    },
              child: const Text(
                "تأكيد",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showdismissDialog(BuildContext context, Student studentData) {
    Get.dialog(
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: AlertDialog(
          backgroundColor: Appcolors.appmaincolor.withOpacity(0.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(
              color: const Color.fromARGB(255, 7, 63, 9),
              width: 2,
            ),
          ),

          title: const Text(
            "تأكيد الفصل",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            "هل انت متاكد من فصل الطالب؟",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w600,
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              child: Text(
                "إلغاء",
                style: TextStyle(
                  color: Appcolors.appmaincolor,
                  fontSize: 16,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolors.appmaincolor,
              ),
              onPressed: studentController.isStudentsLoading.value
                  ? null
                  : () async {
                      bool success = await studentController.dismissStudent(
                        studentData.Id,
                      );
                      if (success) {
                        studentInfoScreenController.changeWindow("البيانات");
                        studentInfoScreenController.dismissreasonController
                            .clear();
                        studentInfoScreenController.dismissdateController
                            .clear();
                      }
                    },
              child: const Text(
                "تأكيد",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //! واجهة التقدم اليومي
  Widget _builddailyprograssWindow(BuildContext context) {
    if (dailyprogresscontroller.dateController.text.isEmpty) {
      dailyprogresscontroller.dateController.text = intl.DateFormat(
        'yyyy-MM-dd',
      ).format(DateTime.now());
    }
    if (dailyprogresscontroller.dayNameController.text.isEmpty) {
      dailyprogresscontroller.dayNameController.text = getdayname();
    }
    if (dailyprogresscontroller.monthController.text.isEmpty) {
      dailyprogresscontroller.monthController.text = getmounthname();
    }
    if (dailyprogresscontroller.yearController.text.isEmpty) {
      dailyprogresscontroller.yearController.text = getyear();
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  readOnly: true,
                  controller: dailyprogresscontroller.dateController,
                  labelText: "التاريخ",
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );

                    if (pickedDate != null) {
                      String day = intl.DateFormat(
                        'EEEE',
                        'ar',
                      ).format(pickedDate);
                      String month = intl.DateFormat(
                        'MMMM',
                        'ar',
                      ).format(pickedDate);
                      String year = intl.DateFormat(
                        'yyyy',
                        'en',
                      ).format(pickedDate);
                      dailyprogresscontroller.dateController.text =
                          intl.DateFormat('yyyy-MM-dd').format(pickedDate);
                      dailyprogresscontroller.setdayname(day);
                      dailyprogresscontroller.setmonth(month);
                      dailyprogresscontroller.setyear(year);
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),

          Row(
            children: [
              Expanded(
                child: Obx(
                  () => _builddatecard(
                    "اليوم",
                    dailyprogresscontroller.dayName.value ?? getdayname(),
                  ),
                ),
              ),
              Expanded(
                child: Obx(
                  () => _builddatecard(
                    "الشهر",
                    dailyprogresscontroller.month.value ?? getmounthname(),
                  ),
                ),
              ),
              Expanded(
                child: Obx(
                  () => _builddatecard(
                    "السنة",
                    dailyprogresscontroller.year.value ?? getyear(),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  readOnly: true,
                  controller: dailyprogresscontroller.dateController,
                  labelText: "الشهر",
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Obx(
            () => Dropdown(
              label: "الحضور",
              items: const ["حاضر", "غائب", "مستأذن"],
              value: dailyprogresscontroller.attendance.value,
              onChanged: (value) {
                dailyprogresscontroller.setAttendance(value);
              },
            ),
          ),
          const SizedBox(height: 10),
          Obx(() {
            if (dailyprogresscontroller.attendance.value != "حاضر") {
              return const SizedBox.shrink();
            } else {
              return Column(
                children: [
                  _buildcard(
                    Column(
                      children: [
                        _buildcliprect("الحفظ"),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: CustomTextField(
                                controller: dailyprogresscontroller
                                    .memorizationSorahController,
                                labelText: 'السورة',
                                fillColor: Colors.white,
                                items: surahController.getsurahnames(),
                                onChanged: (value) {
                                  surahController.ayatcount.value =
                                      surahController.getayatcount(value ?? "");
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Obx(
                                () => CustomTextField(
                                  controller: dailyprogresscontroller
                                      .memorizationAyahController,
                                  labelText: "الاية",
                                  hintText:
                                      "1 - ${surahController.ayatcount.value}",
                                  fillColor: Colors.white,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Obx(
                                () => Dropdown(
                                  label: "المستوى",
                                  items: levelOptions,
                                  value: dailyprogresscontroller
                                      .memorizationLevel
                                      .value,
                                  isExpanded: false,
                                  onChanged: (value) {
                                    dailyprogresscontroller
                                            .memorizationLevel
                                            .value =
                                        value;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  _buildcard(
                    Column(
                      children: [
                        _buildcliprect("المراجعة"),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: CustomTextField(
                                controller: dailyprogresscontroller
                                    .revisionSorahController,
                                labelText: 'السورة',
                                fillColor: Colors.white,
                                items: surahController.getsurahnames(),
                                onChanged: (value) {
                                  surahController.getayatcount(value ?? "");
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: CustomTextField(
                                controller: dailyprogresscontroller
                                    .revisionAyahController,
                                labelText: "الاية",
                                hintText:
                                    "1 - ${surahController.ayatcount.value}",
                                fillColor: Colors.white,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Obx(
                                () => Dropdown(
                                  label: "المستوى",
                                  items: levelOptions,
                                  value: dailyprogresscontroller
                                      .revisionLevel
                                      .value,
                                  isExpanded: false,
                                  onChanged: (value) {
                                    dailyprogresscontroller
                                            .revisionLevel
                                            .value =
                                        value;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    maxLines: 3,
                    controller: dailyprogresscontroller.notesController,
                    labelText: "ملاحظات",
                    fillColor: Colors.white,
                    keyboardType: TextInputType.text,
                  ),
                ],
              );
            }
          }),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 55,
            decoration: BoxDecoration(
              color: Appcolors.appmaincolor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ElevatedButton(
              onPressed: () {
                final student = studentController.selectedStudent.value;
                if (student == null) return;

                Map<String, dynamic> studentUpdates = {};

                // Only update student position if level is not 'Weak' (ضعيف)
                if (dailyprogresscontroller
                        .memorizationSorahController
                        .text
                        .isNotEmpty &&
                    dailyprogresscontroller.memorizationLevel.value != 'ضعيف') {
                  studentUpdates.addAll({
                    "current_Memorization_Sorah": dailyprogresscontroller
                        .memorizationSorahController
                        .text,
                    "current_Memorization_Aya":
                        dailyprogresscontroller.memorizationAyahController.text,
                  });
                }

                if (dailyprogresscontroller
                        .revisionSorahController
                        .text
                        .isNotEmpty &&
                    dailyprogresscontroller.revisionLevel.value != 'ضعيف') {
                  studentUpdates.addAll({
                    "current_Revision_Sorah":
                        dailyprogresscontroller.revisionSorahController.text,
                    "current_Revision_Aya":
                        int.tryParse(
                          dailyprogresscontroller.revisionAyahController.text,
                        ) ??
                        0,
                  });
                }

                bool isAbsent =
                    dailyprogresscontroller.attendance.value != "حاضر";
                Map<String, dynamic> dailyProgressData = {
                  "Attendance": dailyprogresscontroller.attendance.value,
                  "Memorization_Progress_Surah": isAbsent
                      ? "-"
                      : dailyprogresscontroller
                            .memorizationSorahController
                            .text,
                  "Memorization_Progress_Ayah": isAbsent
                      ? 0
                      : int.tryParse(
                              dailyprogresscontroller
                                  .memorizationAyahController
                                  .text,
                            ) ??
                            0,
                  "Revision_Progress_Surah": isAbsent
                      ? "-"
                      : dailyprogresscontroller.revisionSorahController.text,
                  "Revision_Progress_Ayah": isAbsent
                      ? 0
                      : int.tryParse(
                              dailyprogresscontroller
                                  .revisionAyahController
                                  .text,
                            ) ??
                            0,
                  "Memorization_Level": isAbsent
                      ? "-"
                      : dailyprogresscontroller.memorizationLevel.value,
                  "Revision_Level": isAbsent
                      ? "-"
                      : dailyprogresscontroller.revisionLevel.value,
                  "Notes": dailyprogresscontroller.notesController.text,
                  "month": dailyprogresscontroller.monthController.text,
                  "DayName": dailyprogresscontroller.dayNameController.text,
                  "Date": dailyprogresscontroller.dateController.text,
                  "year": dailyprogresscontroller.yearController.text,
                  "Month_year":
                      "${dailyprogresscontroller.monthController.text}-${dailyprogresscontroller.yearController.text}",
                  "StudentId": student.Id,
                };

                _showadddailyprogressDialog(
                  context,
                  dailyProgressData,
                  studentUpdates: studentUpdates.isNotEmpty
                      ? studentUpdates
                      : null,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                "إضافة",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildcard(Widget widget) {
    return Card(
      color: Colors.white,
      elevation: 6,
      // margin: const EdgeInsets.all(5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(padding: const EdgeInsets.all(12.0), child: widget),
    );
  }

  void _showadddailyprogressDialog(
    BuildContext context,
    Map<String, dynamic> dailyProgressData, {
    Map<String, dynamic>? studentUpdates,
  }) {
    Get.dialog(
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: AlertDialog(
          backgroundColor: Appcolors.appmaincolor.withOpacity(0.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: const BorderSide(
              color: Color.fromARGB(255, 7, 63, 9),
              width: 2,
            ),
          ),
          title: const Text(
            "تأكيد إضافة التقدم اليومي",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            "هل انت متاكد من إضافة التقدم اليومي؟",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w600,
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              child: Text(
                "إلغاء",
                style: TextStyle(
                  color: Appcolors.appmaincolor,
                  fontSize: 16,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Obx(
              () => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Appcolors.appmaincolor,
                ),
                onPressed: dailyprogresscontroller.isLoading.value
                    ? null
                    : () async {
                        print("Submitting Daily Progress: $dailyProgressData");

                        // 1. Update student position if needed
                        if (studentUpdates != null) {
                          int studentId =
                              studentController.selectedStudent.value!.Id;
                          await studentController.updateStudent(
                            studentId,
                            studentUpdates,
                          );
                        }

                        // 2. Add daily progress record
                        bool success = await dailyprogresscontroller
                            .adddailyprogress(dailyProgressData);

                        if (success) {
                          studentInfoScreenController.changeWindow("البيانات");
                        }
                      },
                child: dailyprogresscontroller.isLoading.value
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        "تأكيد",
                        style: TextStyle(
                          color: Color.fromARGB(255, 242, 244, 242),
                          fontSize: 16,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _builddatecard(String laple, String value) {
    return Card(
      color: Colors.white,
      elevation: 6,
      margin: const EdgeInsets.all(5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,

              decoration: BoxDecoration(
                color: Appcolors.appmaincolor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Center(
                child: Text(
                  laple,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                ),
              ),
            ),
            Container(child: Text(value)),
          ],
        ),
      ),
    );
  }

  Widget _buildinfowindow(Student studentData) {
    return _buildcard(
      SingleChildScrollView(
        padding: const EdgeInsets.only(top: 8, bottom: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildStudentInfo("الاسم", studentData.Name),
            _buildStudentInfo("رقم الهاتف", studentData.phoneNumber),
            _buildStudentInfo("العمر", studentData.Age.toString()),
            _buildStudentInfo("الفئة", studentData.Category),
            _buildStudentInfo("النوع", studentData.Gender),
            _buildStudentInfo(
              "الحفظ الحالي",
              " سورة ${studentData.current_Memorization_Sorah} آية ${studentData.current_Memorization_Aya}",
            ),
            _buildStudentInfo("الحالة", studentData.status),
            _buildStudentInfo("رقم ولي الأمر", studentData.FatherNumber),
          ],
        ),
      ),
    );
  }

  //! واجهة تعديل بيانات الطالب
  Widget _buildeditwindow(Student studentData, BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 8, bottom: 80),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20, top: 10),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Obx(
                          () => Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Appcolors.appmaincolor,
                                width: 3,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  uploadsController.uploadedImageUrl.isNotEmpty
                                  ? NetworkImage(
                                      uploadsController.uploadedImageUrl.value,
                                    )
                                  : (studentData.ImageUrl != null &&
                                            studentData.ImageUrl!.isNotEmpty
                                        ? NetworkImage(studentData.ImageUrl!)
                                        : null),
                              child:
                                  uploadsController.uploadedImageUrl.isEmpty &&
                                      (studentData.ImageUrl == null ||
                                          studentData.ImageUrl!.isEmpty)
                                  ? Icon(
                                      Icons.person,
                                      size: 60,
                                      color: Appcolors.appmaincolor,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () => uploadsController.pickAndUploadImage(),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Appcolors.appmaincolor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: Obx(
                                () => uploadsController.isUploading.value
                                    ? const SizedBox(
                                        width: 15,
                                        height: 15,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        controller:
                            studentInfoScreenController.textfildnamecontroller,
                        labelText: "الاسم",
                        prefixIcon: Icons.person,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller:
                            studentInfoScreenController.textfildagecontroller,
                        labelText: "العمر",
                        prefixIcon: Icons.cake,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Dropdown(
                    items: statusOptions,
                    value:
                        statusOptions.contains(
                          studentInfoScreenController
                              .textfildstatuscontroller
                              .text,
                        )
                        ? studentInfoScreenController
                              .textfildstatuscontroller
                              .text
                        : null,
                    hintText: 'الحالة',
                    label: 'الحالة',

                    icon: Icons.info,
                    fillColor: Colors.white,
                    onChanged: (value) =>
                        studentInfoScreenController
                            .textfildstatuscontroller
                            .text = value
                            .toString(),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: Dropdown(
                    items: genderOptions,
                    value:
                        genderOptions.contains(
                          studentInfoScreenController
                              .textfildgendercontroller
                              .text,
                        )
                        ? studentInfoScreenController
                              .textfildgendercontroller
                              .text
                        : null,
                    hintText: 'النوع',
                    label: 'النوع',
                    icon: Icons.people,
                    fillColor: Colors.white,
                    onChanged: (value) =>
                        studentInfoScreenController
                            .textfildgendercontroller
                            .text = value
                            .toString(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Dropdown(
              items: categoryOptions,
              value:
                  categoryOptions.contains(
                    studentInfoScreenController.textfildcatigorycontroller.text,
                  )
                  ? studentInfoScreenController.textfildcatigorycontroller.text
                  : null,
              hintText: 'الفئة',
              label: 'الفئة',
              icon: Icons.category,
              fillColor: Colors.white,
              onChanged: (value) =>
                  studentInfoScreenController.textfildcatigorycontroller.text =
                      value.toString(),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CustomTextField(
                    controller: studentInfoScreenController
                        .textfildcurrent_memorization_sorahcontroller,
                    hintText: 'السورة الحالية',
                    labelText: 'السورة',
                    fillColor: Colors.white,
                    items: surahController.getsurahnames(),
                    onChanged: (value) {
                      surahController.ayatcount.value = surahController
                          .getayatcount(value ?? "");
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: Obx(
                    () => CustomTextField(
                      controller: studentInfoScreenController
                          .textfildcurrent_memorization_ayacontroller,
                      labelText: "الاية",
                      hintText: "(1 - ${surahController.ayatcount.value})",
                      fillColor: Colors.white,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller:
                  studentInfoScreenController.textfildphonenumbercontroller,
              labelText: "رقم الهاتف",
              prefixIcon: Icons.phone,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller:
                  studentInfoScreenController.textfildfathernumbercontroller,
              labelText: "رقم ولي الأمر",
              prefixIcon: Icons.contact_phone,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller:
                  studentInfoScreenController.textfildpasswordcontroller,
              labelText: "كلمة المرور",
              prefixIcon: Icons.lock,
              obscureText: true,
            ),
            const SizedBox(height: 30),

            // Save Changes Button
            Obx(
              () => Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  color: Appcolors.appmaincolor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Appcolors.appmaincolor.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    _showUpdateDialog(context, studentData);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: studentController.isStudentsLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "حفظ التغييرات",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  //! واجهة فصل الطالب
  Widget _builddissmiswindow(BuildContext context, Student studentData) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 8, bottom: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            SizedBox(
              child: Center(
                child: Text(
                  "فصل الطالب",
                  style: TextStyle(
                    color: Appcolors.appmaincolor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 140,
              width: double.infinity,
              child: CustomTextField(
                controller: studentInfoScreenController.dismissreasonController,
                labelText: "سبب الفصل",
                keyboardType: TextInputType.multiline,
                maxLines: null,
                expands: true,
              ),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              readOnly: true,
              controller: studentInfoScreenController.dismissdateController,
              labelText: "تاريخ الفصل",

              //hintText: "أدخل تاريخ الفصل",
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.light(
                          primary: Appcolors.appmaincolor,
                          onPrimary: Colors.white,
                          onSurface: Appcolors.appmaincolor,
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                            foregroundColor: Appcolors.appmaincolor,
                          ),
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (pickedDate != null) {
                  studentInfoScreenController.dismissdateController.text =
                      intl.DateFormat('yyyy-MM-dd').format(pickedDate);
                }
              },
            ),
            const SizedBox(height: 30),
            Obx(
              () => Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  color: Appcolors.appmaincolor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Appcolors.appmaincolor.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    _showdismissDialog(context, studentData);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: studentController.isStudentsLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "تأكيد الفصل",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                          ),
                        ),
                ),
              ),
            ),
            //   const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _studentplanwindow(BuildContext context) {
    // تهيئة القيم الافتراضية
    if (studentPlanController.startdatecontroller.text.isEmpty) {
      studentPlanController.startdatecontroller.text = intl.DateFormat(
        'yyyy-MM-dd',
      ).format(DateTime.now());
    }
    if (studentPlanController.enddatecontroller.text.isEmpty) {
      studentPlanController.enddatecontroller.text = intl.DateFormat(
        'yyyy-MM-dd',
      ).format(DateTime.now());
    }
    final student = studentController.selectedStudent.value;
    if (student != null) {
      studentPlanController.getStudentPlans(student.Id);
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _buildPlanNavigation(),
              const SizedBox(height: 15),
              Obx(() {
                switch (studentPlanController.currentplanewindow.value) {
                  case "addplan":
                    return addplane(context);
                  case "reviseplan":
                    return reviseplan(context);
                  case "allplans":
                    return allplans(context);
                  default:
                    // Set default if empty
                    if (studentPlanController
                        .currentplanewindow
                        .value
                        .isEmpty) {
                      Future.delayed(Duration.zero, () {
                        studentPlanController.currentplanewindow.value =
                            "addplan";
                      });
                    }
                    return addplane(context);
                }
              }),
            ],
          ),
          // addplane(context),
        ),
      ),
    );
  }

  Column addplane(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),

        // ─── تاريخ البدء ───────────────────────────────────────────
        _buildcard(
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      readOnly: true,
                      controller: studentPlanController.startdatecontroller,
                      labelText: "تاريخ البدء",
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                          if (picked != null) {
                            studentPlanController.startdatecontroller.text =
                                intl.DateFormat('yyyy-MM-dd').format(picked);
                            studentPlanController.setstartday(
                                intl.DateFormat('EEEE', 'ar').format(picked));
                            studentPlanController.setstartmonth(
                                intl.DateFormat('MMMM', 'ar').format(picked));
                            studentPlanController.setstartyear(
                                intl.DateFormat('yyyy').format(picked));

                            studentPlanController.updateDaysFromDates();
                          }
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => _builddatecard(
                        "اليوم",
                        studentPlanController.startday.value != '-'
                            ? studentPlanController.startday.value
                            : getdayname(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Obx(
                      () => _builddatecard(
                        "الشهر",
                        studentPlanController.startmonth.value != '-'
                            ? studentPlanController.startmonth.value
                            : getmounthname(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Obx(
                      () => _builddatecard(
                        "السنة",
                        studentPlanController.startyear.value != '-'
                            ? studentPlanController.startyear.value
                            : getyear(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // ─── تاريخ الانتهاء ────────────────────────────────────────
        _buildcard(
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      readOnly: true,
                      controller: studentPlanController.enddatecontroller,
                      labelText: "تاريخ الانتهاء",
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) {
                          studentPlanController.enddatecontroller.text =
                              intl.DateFormat('yyyy-MM-dd').format(picked);
                          studentPlanController.setendday(
                              intl.DateFormat('EEEE', 'ar').format(picked));
                          studentPlanController.setendmonth(
                              intl.DateFormat('MMMM', 'ar').format(picked));
                          studentPlanController.setendyear(
                              intl.DateFormat('yyyy').format(picked));

                          studentPlanController.updateDaysFromDates();
                        }
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => _builddatecard(
                        "اليوم",
                        studentPlanController.endday.value != '-'
                            ? studentPlanController.endday.value
                            : getdayname(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Obx(
                      () => _builddatecard(
                        "الشهر",
                        studentPlanController.endmonth.value != '-'
                            ? studentPlanController.endmonth.value
                            : getmounthname(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Obx(
                      () => _builddatecard(
                        "السنة",
                        studentPlanController.endyear.value != '-'
                            ? studentPlanController.endyear.value
                            : getyear(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Obx(() => _buildcard(
              Column(
                children: [
                  Text(
                    "إجمالي أيام الفترة: ${studentPlanController.totalPeriodDays.value}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Appcolors.appmaincolor),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          labelText: "أيام الحفظ",
                          hintText: "عدد الأيام",
                          controller: studentPlanController.memorizationDaysController,
                          keyboardType: TextInputType.number,
                          onChanged: (v) =>
                              studentPlanController.memorizationDays.value = v,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomTextField(
                          labelText: "أيام المراجعة",
                          hintText: "عدد الأيام",
                          controller: studentPlanController.revisionDaysController,
                          keyboardType: TextInputType.number,
                          onChanged: (v) =>
                              studentPlanController.revisionDays.value = v,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),

        // ─── خطة الحفظ ────────────────────────────────────────────
        _buildpalndatecard(
          "خطة الحفظ",
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: studentPlanController
                          .dailyMemorizationAmountController,
                      labelText: "مقدار الحفظ (وجه/يوم)",
                      keyboardType: TextInputType.number,
                      onChanged: (v) {
                        studentPlanController.onDailyAmountChanged(v);
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildpalndatecard(
                      "من",
                      Column(
                        children: [
                          Obx(() {
                            final controller = studentPlanController;
                            final student =
                                studentController.selectedStudent.value;

                            String surahInput =
                                student?.current_Memorization_Sorah ?? "114";

                            String surahName;

                            // ✅ التصحيح هنا
                            int? surahNumber = int.tryParse(surahInput);

                            if (surahNumber != null) {
                              surahName = surahController.getsurahname(
                                surahNumber,
                              );
                            } else {
                              surahName = surahInput; // إذا كان اسم جاهز
                            }

                            return _buildverticalcard(
                              "السورة",
                              Text(
                                surahName,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Appcolors.appmaincolor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          }),

                          Obx(() {
                            final controller = studentPlanController;
                            final student =
                                studentController.selectedStudent.value;

                            String ayah =
                                controller
                                    .startMemorizationVerseController
                                    .text
                                    .isNotEmpty
                                ? controller
                                      .startMemorizationVerseController
                                      .text
                                : student?.current_Memorization_Aya ?? "1";
                            return Column(
                              children: [
                                _buildverticalcard(
                                  "الآية",
                                  Text(
                                    ayah,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Appcolors.appmaincolor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                _buildverticalcard(
                                  "الصفحة",
                                  Text(
                                    studentPlanController.Currentpage.value
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Appcolors.appmaincolor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: _buildpalndatecard(
                      "إلى",
                      Obx(() {
                        final r = studentPlanController.result.value;
                        return Column(
                          children: [
                            _buildverticalcard(
                              "السورة",
                              Text(
                                r?.surahName ?? "—",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Appcolors.appmaincolor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            _buildverticalcard(
                              "الآية",
                              Text(
                                r != null ? r.verse.toString() : "—",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Appcolors.appmaincolor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            _buildverticalcard(
                              "الصفحة",
                              Text(
                                r != null ? r.page.toString() : "—",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Appcolors.appmaincolor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // ─── خطة المراجعة ─────────────────────────────────────────
        _buildpalndatecard(
          "خطة المراجعة",
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller:
                          studentPlanController.dailyRevisionAmountController,
                      labelText: "مقدار المراجعة (جزء/يوم)",
                      keyboardType: TextInputType.number,
                      onChanged: (v) {
                        studentPlanController.onDailyRevisionAmountChanged(v);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Obx(() => Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Appcolors.appmaincolor.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Appcolors.appmaincolor.withOpacity(0.1),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: _buildDirectionOption(
                                  "أمامي",
                                  RevisionDirection.forward,
                                  Icons.arrow_forward_ios,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: _buildDirectionOption(
                                  "عكسي",
                                  RevisionDirection.backward,
                                  Icons.arrow_back_ios,
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildpalndatecard(
                      "من",
                      Column(
                        children: [
                          Obx(() {
                            int surahIndex =
                                studentPlanController.startRevisionSurah.value;
                            String surahName = surahController.getsurahname(
                              surahIndex,
                            );

                            return _buildverticalcard(
                              "السورة",
                              Text(
                                surahName,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Appcolors.appmaincolor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          }),

                          Obx(() {
                            int verse =
                                studentPlanController.startRevisionVerse.value;
                            return Column(
                              children: [
                                _buildverticalcard(
                                  "الآية",
                                  Text(
                                    verse.toString(),
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Appcolors.appmaincolor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                _buildverticalcard(
                                  "الصفحة",
                                  Text(
                                    studentPlanController
                                        .CurrentRevisionPage
                                        .value
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Appcolors.appmaincolor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: _buildpalndatecard(
                      "إلى",
                      Obx(() {
                        final r = studentPlanController.revisionResult.value;
                        return Column(
                          children: [
                            _buildverticalcard(
                              "السورة",
                              Text(
                                r?.surahName ?? "—",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Appcolors.appmaincolor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            _buildverticalcard(
                              "الآية",
                              Text(
                                r != null ? r.verse.toString() : "—",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Appcolors.appmaincolor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            _buildverticalcard(
                              "الصفحة",
                              Text(
                                r != null ? r.page.toString() : "—",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Appcolors.appmaincolor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            _buildverticalcard(
                              "الدورات",
                              Text(
                                studentPlanController.revisionCycles.value
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Appcolors.appmaincolor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          height: 55,
          decoration: BoxDecoration(
            color: Appcolors.appmaincolor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Appcolors.appmaincolor.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Obx(() {
            return ElevatedButton(
              onPressed: studentPlanController.isLoading.value
                  ? null
                  : () => studentPlanController.saveCurrentPlan(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: studentPlanController.isLoading.value
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      "حفظ الخطة",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                      ),
                    ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildPlanNavigation() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildNavButton(
              "إضافة خطة",
              "addplan",
              Icons.add_circle_outline,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildNavButton("الخطط السابقة", "allplans", Icons.history),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(
    String title,
    String window,
    IconData icon, {
    VoidCallback? onTap,
  }) {
    return Obx(() {
      bool isActive =
          studentPlanController.currentplanewindow.value == window ||
          (studentPlanController.currentplanewindow.value.isEmpty &&
              window == "addplan");
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap:
            onTap ??
            () {
              studentPlanController.currentplanewindow.value = window;
              if (window == "allplans") {
                final student = studentController.selectedStudent.value;
                if (student != null) {
                  studentPlanController.getStudentPlans(student.Id);
                }
              }
            },
        child: AnimatedContainer(
          width: double.infinity,
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive
                ? Appcolors.appmaincolor
                : Appcolors.appmaincolor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: isActive
                  ? Appcolors.appmaincolor
                  : Appcolors.appmaincolor.withOpacity(0.1),
              width: 1,
            ),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: Appcolors.appmaincolor.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isActive ? Colors.white : Appcolors.appmaincolor,
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.grey[600],
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  fontSize: 13,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget reviseplan(BuildContext context) {
    return _buildUnderDevelopment();
  }

  Widget allplans(BuildContext context) {
    return Obx(() {
      if (studentPlanController.isLoading.value) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(40.0),
            child: CircularProgressIndicator(),
          ),
        );
      }

      if (studentPlanController.studentPlans.isEmpty) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: [
                Icon(
                  Icons.assignment_late_outlined,
                  size: 60,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 10),
                Text(
                  "لا توجد خطط مسجلة لهذا الطالب",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                    fontFamily: 'Cairo',
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    studentPlanController.setcurrentplanewindow("addplan");
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text(
                    "إضافة خطة",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Appcolors.appmaincolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "سجل الخطط الدراسية",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                    color: Appcolors.appmaincolor,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    studentPlanController.setcurrentplanewindow("addplan");
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text(
                    "خطة جديدة",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Appcolors.appmaincolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ...studentPlanController.studentPlans
              .map((plan) => _buildPlanRecordCard(plan))
              .toList(),
        ],
      );
    });
  }

  Widget _buildPlanRecordCard(StudentPlan plan) {
    final bool itsdone = plan.status == "منفذة";
    final bool isunder = plan.status == "قيد التنفيذ";
    final bool isended = plan.status == "منتهية";

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: isended
              ? Appcolors.appmaincolor.withOpacity(0.1)
              : isunder
                  ? Colors.orange.withOpacity(0.2)
                  : Appcolors.appmaincolor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 55,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: itsdone
                        ? [
                            Appcolors.appmaincolor,
                            Appcolors.appmaincolor.withOpacity(0.8),
                          ]
                        : isunder
                            ? [Colors.orange.shade400, Colors.orange.shade600]
                            : [Colors.red.shade400, Colors.red.shade600],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isunder
                          ? Icons.star_rounded
                          : itsdone
                              ? Icons.check_circle_rounded
                              : Icons.history_rounded,
                      color: Colors.white,
                      size: 26,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      plan.status,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "خطة شهر: ${plan.Month} ${plan.Year}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              fontFamily: 'Cairo',
                              color: Colors.black87,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => _confirmDeletePlan(plan),
                                icon: Icon(
                                  Icons.delete_outline,
                                  size: 20,
                                  color: Colors.red.shade300,
                                ),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                              IconButton(
                                onPressed: () => {},
                                icon: Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: Colors.red.shade300,
                                ),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Divider(height: 1, thickness: 0.5),
                      ),
                      _buildplanstatusbadge(
                        plan,
                        Icons.menu_book_rounded,
                        "الهدف",
                        "خطة الحفظ",
                        isRevision: false,
                      ),
                      const SizedBox(height: 15),
                      _buildplanstatusbadge(
                        plan,
                        Icons.replay_rounded,
                        "الهدف",
                        "خطة المراجعة",
                        isRevision: true,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusTag(bool isDone, bool isCurrent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: isDone
                ? Colors.green.withOpacity(0.1)
                : Colors.orange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            isDone ? "مكتملة" : "قيد التنفيذ",
            style: TextStyle(
              color: isDone ? Colors.green : Colors.orange,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
            ),
          ),
        ),
        if (isCurrent) ...[
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Appcolors.appmaincolor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              "خطة الشهر الحالية",
              style: TextStyle(
                color: Appcolors.appmaincolor,
                fontSize: 9,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPlanInfoItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 5),
        Text(
          "$label: ",
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
  

  Widget _buldlapevaluecard(String laple,String Value)
  {
    return Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  laple,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    fontFamily: 'Cairo',
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  Value,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ),
          );
  }

  void _confirmDeletePlan(StudentPlan plan) {
    Get.dialog(
      AlertDialog(
        title: const Text("حذف الخطة", style: TextStyle(fontFamily: 'Cairo')),
        content: const Text(
          "هل أنت متأكد من رغبتك في حذف هذه الخطة؟",
          style: TextStyle(fontFamily: 'Cairo'),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("إلغاء", style: TextStyle(fontFamily: 'Cairo')),
          ),
          TextButton(
            onPressed: () {
              if (plan.Id != null) {
                studentPlanController.deleteStudentPlan(plan.Id!);
              }
              Get.back();
            },
            child: const Text(
              "حذف",
              style: TextStyle(color: Colors.red, fontFamily: 'Cairo'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildpalndatecard(String laple, Widget widget) {
    return Card(
      color: Colors.white,
      elevation: 6,
      margin: const EdgeInsets.all(5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Appcolors.appmaincolor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    laple,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.all(6), child: widget),
          ],
        ),
      ),
    );
  }

  Widget _buildverticalcard(String laple, Widget widget) {
    return Card(
      color: Colors.white,
      elevation: 3,
      borderOnForeground: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          bottomLeft: Radius.circular(16),
        ),
        side: BorderSide(color: Appcolors.appmaincolor, width: 1),
      ),
      //margin: const EdgeInsets.all(5),
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
      //   topLeft: Radius.circular(15),
      //   bottomLeft: Radius.circular(15),

      // )),
      child: Padding(
        padding: const EdgeInsets.only(top: 1.0, bottom: 1.0, left: 1.0),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 45,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Appcolors.appmaincolor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      laple,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(child: widget),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildhistorywindow(Student studentData) {
    // Reset if student changed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (dailyprogresscontroller.monthyearnames.isEmpty) {
        dailyprogresscontroller.fetchMonthYearNames(studentData.Id).then((_) {
          if (dailyprogresscontroller.monthyearnames.isNotEmpty) {
            String currentMonthYear = "${getmounthname()}-${getyear()}";
            if (dailyprogresscontroller.monthyearnames.contains(
              currentMonthYear,
            )) {
              dailyprogresscontroller.selectedMonthYear.value =
                  currentMonthYear;
              dailyprogresscontroller.fetchHistory(
                studentData.Id,
                currentMonthYear,
              );
            } else {
              dailyprogresscontroller.selectedMonthYear.value =
                  dailyprogresscontroller.monthyearnames.first;
              dailyprogresscontroller.fetchHistory(
                studentData.Id,
                dailyprogresscontroller.monthyearnames.first,
              );
            }
          }
        });
      }
    });

    return Column(
      children: [
        const SizedBox(height: 10),
        // Horizontal Month Bar
        Obx(() {
          if (dailyprogresscontroller.monthyearnames.isEmpty) {
            return const SizedBox.shrink();
          }
          return Center(
            child: Container(
              height: 50,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dailyprogresscontroller.monthyearnames.length,
                itemBuilder: (context, index) {
                  String monthYear =
                      dailyprogresscontroller.monthyearnames[index];
                  bool isSelected =
                      dailyprogresscontroller.selectedMonthYear.value ==
                      monthYear;
                  return GestureDetector(
                    onTap: () {
                      dailyprogresscontroller.selectedMonthYear.value =
                          monthYear;
                      dailyprogresscontroller.fetchHistory(
                        studentData.Id,
                        monthYear,
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Appcolors.appmaincolor
                            : Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: Appcolors.appmaincolor.withOpacity(
                                    0.3,
                                  ),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : [],
                      ),
                      child: Center(
                        child: Text(
                          monthYear,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }),

        Expanded(
          child: Obx(() {
            if (dailyprogresscontroller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (dailyprogresscontroller.monthyearhistory.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.history_edu,
                      size: 60,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "لا توجد سجلات لهذا الشهر",
                      style: TextStyle(fontFamily: 'Cairo', color: Colors.grey),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: dailyprogresscontroller.monthyearhistory.length,
              itemBuilder: (context, index) {
                final record = dailyprogresscontroller.monthyearhistory[index];
                return _buildHistoryCard(record);
              },
            );
          }),
        ),
      ],
    );
  }

  Widget _buildHistoryCard(DailyProgress record) {
    final bool isPresent = record.Attendance == "حاضر";
    final bool hasNotes =
        record.Notes != null && record.Notes!.trim().isNotEmpty;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: isPresent
              ? Appcolors.appmaincolor.withOpacity(0.1)
              : Colors.red.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── شريط الحالة الجانبي ──
              Container(
                width: 55,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isPresent
                        ? [
                            Appcolors.appmaincolor,
                            Appcolors.appmaincolor.withOpacity(0.8),
                          ]
                        : [Colors.red.shade400, Colors.red.shade600],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isPresent
                          ? Icons.check_circle_rounded
                          : Icons.cancel_rounded,
                      color: Colors.white,
                      size: 26,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isPresent ? "حاضر" : "غائب",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ],
                ),
              ),

              // ── منطقة المحتوى ──
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // اليوم والتاريخ
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            record.DayName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              fontFamily: 'Cairo',
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            record.Date,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Divider(height: 1, thickness: 0.5),
                      ),

                      if (isPresent) ...[
                        _buildWideDetail(
                          Icons.menu_book_rounded,
                          "الحفظ",
                          "سورة ${record.Memorization_Progress_Surah} (${record.Memorization_Progress_Ayah})",
                          record.Memorization_Level,
                        ),
                        const SizedBox(height: 10),
                        _buildWideDetail(
                          Icons.replay_rounded,
                          "المراجعة",
                          "سورة ${record.Revision_Progress_Surah} (${record.Revision_Progress_Ayah})",
                          record.Revision_Level,
                        ),
                      ] else
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline_rounded,
                                color: Colors.red.shade400,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "عذراً، الطالب غائب في هذا اليوم",
                                style: TextStyle(
                                  color: Colors.red.shade700,
                                  fontFamily: 'Cairo',
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),

                      if (hasNotes) ...[
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFBE6),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFFFE58F)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.sticky_note_2_rounded,
                                    size: 16,
                                    color: Color(0xFFD48806),
                                  ),
                                  const SizedBox(width: 6),
                                  const Text(
                                    "الملاحظات",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFD48806),
                                      fontFamily: 'Cairo',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                record.Notes!,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black87,
                                  fontFamily: 'Cairo',
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWideDetail(
    IconData icon,
    String label,
    String value,
    String level,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Appcolors.appmaincolor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 18, color: Appcolors.appmaincolor),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey.shade500,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Cairo',
                  color: Colors.black87,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        _buildLevelBadge(level),
      ],
    );
  }

  Widget _buildplanstatusbadge(
    StudentPlan plan,
    IconData icon,
    String label,
    String title, {
    required bool isRevision,
  }) {
    double progress =
        studentPlanController.calculateProgress(plan, isRevision: isRevision);
    final statusData = getPlanStatus(progress);

    String value = isRevision
        ? "من ${plan.Current_Revision} إلى ${plan.target_Revision}"
        : "سورة ${plan.target_Memorization_Surah} (${plan.target_Memorization_Ayah})";

    String currentVal = "";
    if (isRevision) {
      currentVal =
          "الحالي: ${studentController.selectedStudent.value?.current_Revision_Sorah ?? "-"} (${studentController.selectedStudent.value?.current_Revision_Aya ?? "-"})";
    } else {
      currentVal =
          "الحالي: ${studentController.selectedStudent.value?.current_Memorization_Sorah ?? "-"} (${studentController.selectedStudent.value?.current_Memorization_Aya ?? "-"})";
    }

    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: (statusData["color"] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(icon, size: 18, color: statusData["color"]),
                  const SizedBox(width: 6),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: statusData["color"],
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade500,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            _buildStatusChip(statusData),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              currentVal,
              style: TextStyle(
                fontSize: 11,
                color: Appcolors.appmaincolor.withOpacity(0.8),
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "${progress.toStringAsFixed(0)}%",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: statusData["color"],
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress / 100,
            backgroundColor: (statusData["color"] as Color).withOpacity(0.1),
            valueColor: AlwaysStoppedAnimation<Color>(statusData["color"]),
            minHeight: 6,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusChip(Map<String, dynamic> statusData) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: (statusData["color"] as Color).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (statusData["color"] as Color).withOpacity(0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(statusData["icon"], size: 12, color: statusData["color"]),
          const SizedBox(width: 4),
          Text(
            statusData["text"],
            style: TextStyle(
              color: statusData["color"],
              fontSize: 10,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelBadge(String level) {
    Color color;
    switch (level) {
      case "ممتاز":
        color = Colors.green.shade700;
        break;
      case "جيد جدا":
        color = Colors.blue.shade700;
        break;
      case "جيد":
        color = Colors.orange.shade700;
        break;
      case "مقبول":
        color = Colors.amber.shade700;
        break;
      case "ضعيف":
        color = Colors.red.shade700;
        break;
      default:
        color = Colors.grey.shade600;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        level,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          fontFamily: 'Cairo',
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 5),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: 'Cairo',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateChip(String label, String date, IconData icon, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.grey,
            fontFamily: 'Cairo',
          ),
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 5),
            Text(
              date,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
                fontSize: 13,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLabelValue(String label, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.grey,
            fontFamily: 'Cairo',
          ),
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            Icon(icon, size: 16, color: Colors.grey.shade600),
            const SizedBox(width: 5),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
                fontSize: 13,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusBadge(String status, Color color) {
    String text;

    switch (status) {
      case 'active':
        text = 'فعال';
        break;
      case 'finished':
        text = 'منتهي';
        break;
      case 'archived':
        text = 'مؤرشف';
        break;
      case 'pending':
        text = 'قيد التنفيذ';
        break;
      case 'passed':
        text = 'ناجح';
        break;
      case 'failed':
        text = 'راسب';
        break;
      default:
        text = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
          fontFamily: 'Cairo',
        ),
      ),
    );
  }

  Widget _buildDirectionOption(
    String title,
    RevisionDirection direction,
    IconData icon,
  ) {
    bool isSelected =
        studentPlanController.revisionDirection.value == direction;
    return GestureDetector(
      onTap: () => studentPlanController.setRevisionDirection(direction),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Appcolors.appmaincolor : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Appcolors.appmaincolor.withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ]
              : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Appcolors.appmaincolor,
              size: 14,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Appcolors.appmaincolor,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> getPlanStatus(double progress) {
    if (progress <= 0) {
      return {
        "text": "لم يبدأ",
        "color": Colors.grey,
        "icon": Icons.timer_outlined,
      };
    } else if (progress <= 30) {
      return {
        "text": "بداية الطريق",
        "color": Colors.redAccent,
        "icon": Icons.hourglass_top,
      };
    } else if (progress <= 70) {
      return {
        "text": "تقدم جيد",
        "color": Colors.orange,
        "icon": Icons.trending_up,
      };
    } else if (progress < 100) {
      return {
        "text": "قارب على الإنجاز",
        "color": Colors.blue,
        "icon": Icons.flag_outlined,
      };
    } else {
      return {
        "text": "مكتمل",
        "color": Colors.green,
        "icon": Icons.check_circle_rounded,
      };
    }
  }
}
