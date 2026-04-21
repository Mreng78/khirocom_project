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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/Controller/StudentInfoScreenController.dart';
import 'package:frontend/Widgets/CustomTextField.dart';
import 'package:frontend/Controller/UploadsController.dart';
import 'package:frontend/models/surah_data.model.dart';
import 'package:frontend/Controller/SurahController.dart';
import 'package:intl/intl.dart' as intl;
import 'package:frontend/Controller/DailyProgresscontroller.dart';
import 'package:frontend/Controller/StudentPlancontroller.dart';

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

  final List<String> attendanceOptions = const ["حضر", "غاب", "اعتذر"];
  final List<String> levelOptions = const [
    "ضعيف",
    "مقبول",
    "جيد",
    "جيد جدا",
    "ممتاز",
    "ــ",
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
    return intl.DateFormat('yyyy', 'ar').format(now);
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
                        icon: FontAwesomeIcons.listCheck,
                        windowname: "الخطة",
                      ),
                      _buildnavbaritems(
                        icon: Icons.info,
                        windowname: "البيانات",
                      ),
                      _buildnavbaritems(
                        icon: FontAwesomeIcons.calendarCheck,
                        windowname: "الأداء اليومي",
                      ),
                      _buildnavbaritems(
                        icon: FontAwesomeIcons.rightLeft,
                        windowname: "نقل",
                      ),
                      _buildnavbaritems(
                        icon: FontAwesomeIcons.circleStop,
                        windowname: "إيقاف",
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
                        'ar',
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
              Obx(
                () => Expanded(
                  child: _builddatecard(
                    "اليوم",
                    dailyprogresscontroller.dayName.value ?? getdayname(),
                  ),
                ),
              ),
              Obx(
                () => Expanded(
                  child: _builddatecard(
                    "الشهر",
                    dailyprogresscontroller.month.value ?? getmounthname(),
                  ),
                ),
              ),
              Obx(
                () => Expanded(
                  child: _builddatecard(
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
                if (dailyprogresscontroller.memorizationSorahController.text.isNotEmpty && 
                    dailyprogresscontroller.memorizationLevel.value != 'ضعيف') {
                  studentUpdates.addAll({
                    "current_Memorization_Sorah": dailyprogresscontroller.memorizationSorahController.text,
                    "current_Memorization_Aya": dailyprogresscontroller.memorizationAyahController.text,
                  });
                }

                if (dailyprogresscontroller.revisionSorahController.text.isNotEmpty && 
                    dailyprogresscontroller.revisionLevel.value != 'ضعيف') {
                  studentUpdates.addAll({
                    "current_Revision_Sorah": dailyprogresscontroller.revisionSorahController.text,
                    "current_Revision_Aya": int.tryParse(dailyprogresscontroller.revisionAyahController.text) ?? 0,
                  });
                }

                Map<String, dynamic> dailyProgressData = {
                  "Attendance": dailyprogresscontroller.attendance.value,
                  "Memorization_Progress_Surah":
                      dailyprogresscontroller.memorizationSorahController.text,
                  "Memorization_Progress_Ayah":
                      int.tryParse(
                        dailyprogresscontroller.memorizationAyahController.text,
                      ) ??
                      0,
                  "Revision_Progress_Surah":
                      dailyprogresscontroller.revisionSorahController.text,
                  "Revision_Progress_Ayah":
                      int.tryParse(
                        dailyprogresscontroller.revisionAyahController.text,
                      ) ??
                      0,
                  "Memorization_Level":
                      dailyprogresscontroller.memorizationLevel.value,
                  "Revision_Level": dailyprogresscontroller.revisionLevel.value,
                  "Notes": dailyprogresscontroller.notesController.text,
                  "month": DateTime.now().month.toString(),
                  "DayName": dailyprogresscontroller.dayNameController.text,
                  "Date": dailyprogresscontroller.dateController.text,
                  "year": DateTime.now().year,
                  "StudentId": student.Id,
                };
                
                _showadddailyprogressDialog(
                  context, 
                  dailyProgressData, 
                  studentUpdates: studentUpdates.isNotEmpty ? studentUpdates : null,
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
                          int studentId = studentController.selectedStudent.value!.Id;
                          await studentController.updateStudent(studentId, studentUpdates);
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

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
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
                            controller:
                                studentPlanController.startdatecontroller,
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
                                    intl.DateFormat(
                                      'yyyy-MM-dd',
                                    ).format(picked);
                                studentPlanController.setstartday(
                                  intl.DateFormat('EEEE', 'ar').format(picked),
                                );
                                studentPlanController.setstartmonth(
                                  intl.DateFormat('MMMM', 'ar').format(picked),
                                );
                                studentPlanController.setstartyear(
                                  intl.DateFormat('yyyy').format(picked),
                                );
                                final end = DateTime.tryParse(
                                  studentPlanController.enddatecontroller.text,
                                );
                                if (end != null) {
                                  final months =
                                      ((end.year - picked.year) * 12 +
                                              end.month -
                                              picked.month)
                                          .clamp(1, 9999);
                                  final perMonth =
                                      int.tryParse(
                                        studentPlanController
                                            .daysController
                                            .text,
                                      ) ??
                                      20;
                                  studentPlanController.days.value =
                                      (perMonth * months).toString();
                                 // studentPlanController.getplanetarget();
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Obx(
                          () => Expanded(
                            child: _builddatecard(
                              "اليوم",
                              studentPlanController.startday.value != '-'
                                  ? studentPlanController.startday.value
                                  : getdayname(),
                            ),
                          ),
                        ),
                        Obx(
                          () => Expanded(
                            child: _builddatecard(
                              "الشهر",
                              studentPlanController.startmonth.value != '-'
                                  ? studentPlanController.startmonth.value
                                  : getmounthname(),
                            ),
                          ),
                        ),
                        Obx(
                          () => Expanded(
                            child: _builddatecard(
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
                                    intl.DateFormat(
                                      'yyyy-MM-dd',
                                    ).format(picked);
                                studentPlanController.setendday(
                                  intl.DateFormat('EEEE', 'ar').format(picked),
                                );
                                studentPlanController.setendmonth(
                                  intl.DateFormat('MMMM', 'ar').format(picked),
                                );
                                studentPlanController.setendyear(
                                  intl.DateFormat('yyyy').format(picked),
                                );
                                // احسب إجمالي أيام الحفظ = أيام/شهر × عدد الأشهر
                                final start = DateTime.tryParse(
                                  studentPlanController
                                      .startdatecontroller
                                      .text,
                                );
                                if (start != null) {
                                  final months =
                                      ((picked.year - start.year) * 12 +
                                              picked.month -
                                              start.month)
                                          .clamp(1, 9999);
                                  final perMonth =
                                      int.tryParse(
                                        studentPlanController
                                            .daysController
                                            .text,
                                      ) ??
                                      20;
                                  studentPlanController.days.value =
                                      (perMonth * months).toString();
                                  studentPlanController.getplanetarget();
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Obx(
                          () => Expanded(
                            child: _builddatecard(
                              "اليوم",
                              studentPlanController.endday.value != '-'
                                  ? studentPlanController.endday.value
                                  : getdayname(),
                            ),
                          ),
                        ),
                        Obx(
                          () => Expanded(
                            child: _builddatecard(
                              "الشهر",
                              studentPlanController.endmonth.value != '-'
                                  ? studentPlanController.endmonth.value
                                  : getmounthname(),
                            ),
                          ),
                        ),
                        Obx(
                          () => Expanded(
                            child: _builddatecard(
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
              _buildcard(
                CustomTextField(
                  controller: studentPlanController.daysController,
                  labelText: "أيام الحفظ والمراجعة في الشهر",
                  keyboardType: TextInputType.number,
                  onChanged: (v) {
                    // إجمالي الأيام = أيام/شهر × عدد الأشهر بين التاريخين
                    final perMonth = int.tryParse(v) ?? 20;
                    final start = DateTime.tryParse(
                      studentPlanController.startdatecontroller.text,
                    );
                    final end = DateTime.tryParse(
                      studentPlanController.enddatecontroller.text,
                    );
                    if (start != null && end != null) {
                      final months =
                          ((end.year - start.year) * 12 +
                                  end.month -
                                  start.month)
                              .clamp(1, 9999);
                      studentPlanController.days.value = (perMonth * months)
                          .toString();
                    } else {
                      studentPlanController.days.value = perMonth.toString();
                    }
                    studentPlanController.getplanetarget();
                  },
                ),
              ),

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
                              studentPlanController
                                  .dailyMemorizationAmount
                                  .value = v.isNotEmpty
                                  ? v
                                  : "1";
                              studentPlanController.getplanetarget();
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

                                  String surahInput = student?.current_Memorization_Sorah ?? "114";

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
                                        studentPlanController.Currentpage.value.toString(),
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
                            controller: studentPlanController
                                .dailyRevisionAmountController,
                            labelText: "مقدار المراجعة (جزء/يوم)",
                            keyboardType: TextInputType.number,
                            onChanged: (v) {
                              int juz = int.tryParse(v) ?? 0;
                              studentPlanController.dailyRevisionAmount.value =
                                  v.isNotEmpty ? (juz * 20).toString() : "1";
                            },
                          ),
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
                                  int surahIndex = studentPlanController.startRevisionSurah.value;
                                  String surahName = surahController.getsurahname(surahIndex);

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
                                  int verse = studentPlanController.startRevisionVerse.value;
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
                                        studentPlanController.CurrentRevisionPage.value.toString(),
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
          ),
        ),
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
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16),bottomLeft: Radius.circular(16)),
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
}
