import "package:flutter/material.dart";
import "package:frontend/Controller/UserController.dart";
import "package:frontend/Controller/HalaqatController.dart";
import "package:frontend/Controller/StudentController.dart";
import "package:frontend/Screans/authscrean/LoginScrean.dart";
import "package:frontend/Widgets/CustomContainer.dart";
import "package:get/get.dart";
import "package:frontend/Widgets/AppColors.dart";
import "package:frontend/Widgets/CustomTextField.dart";
import "package:frontend/Screans/TeacherScrean/Studentinfo.dart";
import "package:frontend/Screans/TeacherScrean/AddStudent.dart";
import "package:frontend/Widgets/CustomBottomNavBar.dart";
import "package:frontend/Controller/Auth_controller.dart";

class TeacherHomescrean extends StatefulWidget {
  const TeacherHomescrean({super.key});

  @override
  State<TeacherHomescrean> createState() => _TeacherHomescreanState();
}

class _TeacherHomescreanState extends State<TeacherHomescrean> {
  final HalaqatController halaqatController = Get.put(HalaqatController());
  final StudentController studentController = Get.put(StudentController());
  final UserController userController = Get.put(UserController());
  final AuthController authController = Get.put(AuthController());
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    
    // Trigger data fetching after initial build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchInitialData();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _fetchInitialData() {
    if (!halaqatController.isLoading.value) {
      final user = authController.currentUser.value;
      if (user == null) {
        print("Error: No user logged in");
        return;
      }
      
      if (halaqatController.currentHalaqah.value == null) {
        halaqatController.gethalaqahbyteacherid(
          user.Id,
        );
      } else if (studentController.students.isEmpty &&
          !studentController.isStudentsLoading.value) {
        studentController.getStudentsByHalaqahId(
          halaqatController.currentHalaqah.value!.Id,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Appcolors.background,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Appcolors.appBarbackground,
        title: const Text(
          "خيركم",
          style: TextStyle(
            color:Color(0xFFFFD700),
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
              authController.user_logout();
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
        decoration: const BoxDecoration(
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
              const SizedBox(height: 10),
              // Styled Header Section
              Obx(() {
                final halaqah = halaqatController.currentHalaqah.value;
                final user = authController.currentUser.value;
                final studentsCount = studentController.students.length;

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Appcolors.appmaincolor, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Stack(
                      children: [
                        // Background with CustomPaint
                        Positioned.fill(
                          child: CustomPaint(
                            painter: Customcontainer(),
                          ),
                        ),
                        // Content Layer
                        Container(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'بيانات الحلقة',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 4,
                                          color: Colors.black.withOpacity(0.3),
                                          offset: const Offset(1, 1),
                                        ),
                                      ],
                                      fontFamily: 'Cairo',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'اسم الحلقة: ${halaqah?.Name ?? "جاري التحميل..."}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'Cairo',
                                    ),
                                  ),
                                  Text(
                                    'نوع الحلقة: ${halaqah?.type ?? ""}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'Cairo',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'المدرس: ${user?.Name ?? ""}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'Cairo',
                                    ),
                                  ),
                                  Text(
                                    'عدد الطلاب: $studentsCount',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'Cairo',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 10),
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
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
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "قائمة الطلاب",
                                style: TextStyle(
                                  color: Appcolors.appmaincolor,
                                  fontSize: 15,
                                  fontFamily: 'cairo',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          CustomTextField(
                            controller: _searchController,
                            hintText: "بحث عن طالب...",
                            prefixIcon: Icons.search,
                            labelText: "بحث عن طالب...",
                            fillColor: Colors.white,
                            textColor: Colors.black87,
                            iconColor: Appcolors.appmaincolor,
                            borderColor: Appcolors.appmaincolor.withOpacity(0.3),
                            onChanged: (value) {
                              final halaqahId = halaqatController.currentHalaqah.value?.Id;
                              if (halaqahId != null) {
                                studentController.searchStudentsOnServer(value, halaqahId);
                              }
                            },
                          ),
                          const SizedBox(height: 5),
                          Expanded(
                            child: Obx(() {
                              final students =
                                  studentController.filteredStudents;
                              if (students.isEmpty) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.search_off,
                                        size: 100,
                                        color: Appcolors.appmaincolor,
                                      ),
                                      Text(
                                        "لا يوجد طلاب بهذا الاسم",
                                        style: TextStyle(
                                          color: Appcolors.appmaincolor,
                                          fontSize: 15,
                                          fontFamily: 'cairo',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        _searchController.text,
                                        style: TextStyle(
                                          color: Appcolors.appmaincolor,
                                          fontSize: 15,
                                          fontFamily: 'cairo',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return ListView.builder(
                                key: const PageStorageKey('student_list'),
                                padding: const EdgeInsets.only(bottom: 110),
                                itemCount: students.length,
                                itemBuilder: (context, index) {
                                  final student = students[index];
                                  Color statusColor = student.status == "مستمر"
                                      ? Colors.green
                                      : Colors.orange;

                                  return Padding(
                                    key: ValueKey(student.Id),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                      vertical: 4,
                                    ),
                                    child: InkWell(
                                      key: ValueKey('inkwell_${student.Id}'),
                                      borderRadius: BorderRadius.circular(20),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                Studentinfo(student: student),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.05,
                                              ),
                                              blurRadius: 10,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                          border: Border.all(
                                            color: Appcolors.appBarbackground
                                                .withOpacity(0.15),
                                          ),
                                        ),
                                        child: ListTile(
                                          dense: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                horizontal: 16,
                                                vertical: 0,
                                              ),
                                          leading: Stack(
                                            children: [
                                              CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Appcolors
                                                    .appBarbackground
                                                    .withOpacity(0.08),
                                                backgroundImage:
                                                    student.ImageUrl != null &&
                                                            student
                                                                .ImageUrl!
                                                                .isNotEmpty
                                                        ? NetworkImage(
                                                            student.ImageUrl!,
                                                          )
                                                        : null,
                                                child: student.ImageUrl == null ||
                                                        student
                                                            .ImageUrl!
                                                            .isEmpty
                                                    ? Text(
                                                        student.Name.isNotEmpty
                                                            ? student.Name[0]
                                                                .toUpperCase()
                                                            : "?",
                                                        style: TextStyle(
                                                          color: Appcolors
                                                              .appBarbackground,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                        ),
                                                      )
                                                    : null,
                                              ),
                                              Positioned(
                                                bottom: 2,
                                                right: 2,
                                                child: Container(
                                                  width: 14,
                                                  height: 14,
                                                  decoration: BoxDecoration(
                                                    color: statusColor,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: Colors.white,
                                                      width: 2,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          title: Text(
                                            student.Name,
                                            style: const TextStyle(
                                              fontFamily: 'Cairo',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                          subtitle: Padding(
                                            padding: const EdgeInsets.only(
                                              top: 2,
                                            ),
                                            child: Text(
                                              "ما وصل اليه : ${student.current_Memorization_Sorah} {${student.current_Memorization_Aya}}",
                                              style: TextStyle(
                                                fontFamily: 'Cairo',
                                                fontSize: 13,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                          ),
                                          trailing: Container(
                                            padding: const EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              color: Appcolors.appBarbackground
                                                  .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              size: 14,
                                              color: Appcolors.appBarbackground,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    CustomBottomNavBar(
                      onProfileTap: () {
                        // Handle profile
                      },
                      onCenterTap: () {
                        Get.to(() => Addstudent());
                      },
                      onRecordsTap: () {
                        // Handle records
                      },
                      centerIcon: Icons.add,
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

  Widget _buildAddButton() {
    return InkWell(
      onTap: () {
        Get.to(() => Addstudent());
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Appcolors.appBarbackground,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Appcolors.appBarbackground.withOpacity(0.4),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 35),
      ),
    );
  }
}
