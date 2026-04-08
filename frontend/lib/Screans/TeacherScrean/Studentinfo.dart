import 'package:flutter/material.dart';
import 'package:frontend/Screans/TeacherScrean/TeacherHomescrean.dart';
import 'package:frontend/Widgets/AppColors.dart';
import 'package:frontend/Widgets/CustomBottomNavBar.dart';
import 'package:frontend/models/Student.model.dart';
import 'package:get/get.dart';
import '../authscrean/LoginScrean.dart';
import '../../Controller/Auth_controller.dart';
import '../../Controller/StudentController.dart';
class Studentinfo extends StatelessWidget {
  final Student student;
  Studentinfo({super.key, required this.student});
  final AuthController authController = Get.put(AuthController());
  final StudentController studentController = Get.put(StudentController());
  final AuthController authService = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Appcolors.appBarbackground,
        title: Text(
          "خيركم",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
          ),
        ),

        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              authService.user_logout();
              Get.offAll(() => Loginscrean());
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {},
          ),
        ],
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
        child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: Appcolors.appmaincolor, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "اسم الطالب :${student.Name}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Appcolors.appmaincolor,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "عمر الطالب :${student.Age}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Appcolors.appmaincolor,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        " ما وصل إليه :${student.current_Memorization_Sorah} {${student.current_Memorization_Aya}}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Appcolors.appmaincolor,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        " الفئة :${student.Category}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Appcolors.appmaincolor,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
           Container(
            decoration: BoxDecoration(
              color:Appcolors.appmaincolor,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: Appcolors.appmaincolor, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                   
                   shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(Icons.edit, color:Colors.white),
                    onPressed: () {},
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                   
                   shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon:  Icon(Icons.delete, color: Colors.white),
                    onPressed: () {
                      studentController.dismissStudent(student.Id);
                    },
                  ),
                ),
                //!NavigationDestination(icon: Icon(Icons.move_to_inbox,color: Appcolors.appmaincolor,), label: "نقل"),
                Container(
                  decoration: BoxDecoration(
                   
                   shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon:  Icon(Icons.stop, color: Colors.white),
                    onPressed: () {},
                   
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                   
                   shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon:  Icon(Icons.assignment, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                   
                   shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon:  Icon(Icons.bar_chart, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
           ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    border: Border.all(color: Appcolors.appmaincolor, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
                    CustomBottomNavBar(
                      onProfileTap: () {
                        // Handle profile
                      },
                      onCenterTap: () {
                        Get.to(() => const TeacherHomescrean());
                      },
                      onRecordsTap: () {
                        // Handle records
                      },
                      centerIcon: Icons.home,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
