import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:frontend/Screans/TeacherScrean/TeacherHomescrean.dart';
import 'package:frontend/Widgets/AppColors.dart';
import 'package:frontend/Widgets/CustomBottomNavBar.dart';
import 'package:frontend/Widgets/appbarcontainer.dart';
import 'package:get/get.dart';
import '../authscrean/LoginScrean.dart';
import '../../Controller/Auth_controller.dart';
import '../../Controller/StudentController.dart';
import '../../Widgets/Customcontainer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Controller/Studentinfoscreancontroller.dart';

class Studentinfo extends StatelessWidget {
  Studentinfo({super.key});
  final AuthController authController = Get.put(AuthController());
  final StudentController studentController = Get.put(StudentController());
  final AuthController authService = Get.put(AuthController());
  final StudentInfoScreanController studentInfoScreanController = Get.put(
    StudentInfoScreanController(),
  );

  final List<String> windows = const [
    "البيانات",
    "تعديل",
    "فصل",
    "الأداء اليومي",
    "الخطة",
    "إيقاف",
    "نقل",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbarcontainer(title: 'بيانات الطالب'),
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

        child: Stack(
          children: [
            Positioned.fill(
             
              child: Obx(() {
                final student = studentController.selectedStudent.value;
                return student != null
                    ? Directionality(
                        textDirection: TextDirection.rtl,
                        child: Column(
                          children: [
                           
                            Container(
                              width: double.infinity,
                              // margin: const EdgeInsets.symmetric(
                              //   horizontal: 10,
                              // ),
                              decoration: BoxDecoration(
                                //borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Appcolors.appmaincolor,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                               // borderRadius: BorderRadius.circular(18),
                                child: Stack(
                                  children: [
                                    // Background with CustomPaint
                                    Positioned.fill(
                                      child: CustomPaint(
                                        painter: Customcontainer(),
                                      ),
                                    ),
                                    // Content Layer
                                    Column(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                radius: 25,
                                                backgroundColor: Colors.white,
                                                backgroundImage:
                                                    student.ImageUrl != null &&
                                                        student
                                                            .ImageUrl!
                                                            .isNotEmpty
                                                    ? NetworkImage(
                                                        student.ImageUrl!,
                                                      )
                                                    : null,
                                                child:
                                                    student.ImageUrl == null ||
                                                        student
                                                            .ImageUrl!
                                                            .isEmpty
                                                    ? Text(
                                                        student.Name.isNotEmpty
                                                            ? student.Name[0]
                                                                  .toUpperCase()
                                                            : "?",
                                                        style: const TextStyle(
                                                          color: Color(
                                                            0xFF1B5E20,
                                                          ),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 32,
                                                        ),
                                                      )
                                                    : null,
                                              ),

                                            
                                              // Student Name
                                              Expanded(
                                                child: Container(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Center(
                                                        child: Text(
                                                          student.Name,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.bold,
                                                            fontFamily: 'Cairo',
                                                            height: 1.3,
                                                          ),
                                                        ),
                                                      )
                                                   
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Navigation Items Section
                                        Divider(
                                          color: Colors.white,
                                          thickness: 1,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(bottom: 10),
                                          child: SizedBox(
                                            height: 35,
                                            child: ListView(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              children: [
                                                _buildnavbaritems(
                                                  icon: Icons.edit,
                                                  windowname: "تعديل",
                                                ),

                                                _buildnavbaritems(
                                                  icon: Icons.delete,
                                                  windowname: "فصل",
                                                ),

                                                _buildnavbaritems(
                                                  icon: FontAwesomeIcons
                                                      .listCheck,
                                                  windowname: "الخطة",
                                                ),
                                                _buildnavbaritems(
                                                  icon: Icons.info,
                                                  windowname: "البيانات",
                                                ),

                                                _buildnavbaritems(
                                                  icon: FontAwesomeIcons
                                                      .calendarCheck,
                                                  windowname: "الأداء اليومي",
                                                ),

                                                _buildnavbaritems(
                                                  icon: FontAwesomeIcons
                                                      .rightLeft,
                                                  windowname: "نقل",
                                                ),

                                                _buildnavbaritems(
                                                  icon: FontAwesomeIcons
                                                      .circleStop,
                                                  windowname: "إيقاف",
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),

                            Expanded(
                              child: Stack(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(15),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      border: Border.all(
                                        color: Appcolors.appmaincolor,
                                        width: 2,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Obx(() {
                                      final studentData = studentController.selectedStudent.value;
                                      if (studentData == null) {
                                        return const Center(child: Text("لا توجد بيانات"));
                                      }

                                      switch (studentInfoScreanController
                                          .selectedwindow
                                          .value) {
                                        case "البيانات":
                                          return SingleChildScrollView(
                                            padding: const EdgeInsets.only(
                                              top: 8,
                                              bottom: 80,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                _buildStudentInfo(
                                                  "الاسم",
                                                  studentData.Name,
                                                ),
                                                _buildStudentInfo(
                                                  "رقم الهاتف",
                                                  studentData.phoneNumber,
                                                ),
                                                _buildStudentInfo(
                                                  "العمر",
                                                  studentData.Age.toString(),
                                                ),
                                                _buildStudentInfo(
                                                  "الفئة",
                                                  studentData.Category,
                                                ),
                                                _buildStudentInfo(
                                                  "النوع",
                                                  studentData.Gender,
                                                ),
                                                _buildStudentInfo(
                                                  "الحفظ الحالي",
                                                  " سورة${studentData.current_Memorization_Sorah} آية ${studentData.current_Memorization_Aya}",
                                                ),
                                                _buildStudentInfo(
                                                  "الحالة",
                                                  studentData.status,
                                                ),
                                                _buildStudentInfo(
                                                  "رقم ولي الأمر",
                                                  studentData.FatherNumber,
                                                ),
                                              ],
                                            ),
                                          );
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
          ],
        ),
      ),
    );
  }

  Widget _buildGlassButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
      ),
      child: Center(
        child: IconButton(
          icon: Icon(icon, color: Colors.white, size: 20),
          onPressed: onTap,
          padding: const EdgeInsets.all(8),
          constraints: const BoxConstraints(),
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
          studentInfoScreanController.selectedwindow.value == windowname;

      return GestureDetector(
        onTap: () {
          studentInfoScreanController.changeWindow(windowname);
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
          Text(
            'سيتم إضافة هذه الميزة قريباً',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 14,
              fontFamily: 'Tajawal',
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a navigation item with icon and label
  Widget _buildNavigationItem({
    required VoidCallback onTap,
    required String label,
    IconData? icon,

    String? iconUrl,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30),
          splashColor: Colors.white.withOpacity(0.15),
          highlightColor: Colors.white.withOpacity(0.05),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildIconContainer(icon: icon, imageUrl: iconUrl),
                const SizedBox(height: 3),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                    height: 1.1,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds an icon container with image or icon support
  Widget _buildIconContainer({IconData? icon, String? imageUrl}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.5), width: 1.5),
      ),
      child: ClipOval(
        child: _buildIconContent(icon: icon, imageUrl: imageUrl),
      ),
    );
  }

  /// Builds the actual icon content (image or icon)
  Widget _buildIconContent({IconData? icon, String? imageUrl}) {
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: Icon(Icons.person, color: Colors.white, size: 18),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Center(
            child: Icon(icon ?? Icons.person, color: Colors.white, size: 18),
          );
        },
      );
    }

    return Center(
      child: Icon(icon ?? Icons.person, color: Colors.white, size: 18),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected) {
    return InkWell(
      onTap: () {
        // Handle navigation
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? Appcolors.appBarbackground : Colors.grey,
            size: 28,
          ),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Appcolors.appBarbackground : Colors.grey,
              fontSize: 12,
              fontFamily: 'Cairo',
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the center add button for the navigation bar
  Widget _buildCenterAddButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Get.to(() => TeacherHomescrean());
        },
        customBorder: const CircleBorder(),
        splashColor: Colors.white.withOpacity(0.2),
        highlightColor: Colors.white.withOpacity(0.1),
        child: Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            gradient: Appcolors.glossyGradient,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Appcolors.appmaincolor.withOpacity(0.4),
                blurRadius: 15,
                offset: const Offset(0, 2),
                spreadRadius: -2,
              ),
            ],
          ),
          child: const Icon(Icons.home, color: Colors.white, size: 28),
        ),
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
}
