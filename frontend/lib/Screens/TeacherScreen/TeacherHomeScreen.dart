import 'dart:ui';
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:frontend/Controller/UserController.dart";
import "package:frontend/Controller/HalaqatController.dart";
import "package:frontend/Controller/StudentController.dart";
import "package:frontend/Screens/TeacherScreen/StudentInfoScreen.dart";
import "package:frontend/Widgets/CustomContainer.dart";
import "package:frontend/Widgets/DropDown.dart";
import "package:frontend/Widgets/appbarcontainer.dart";
import "package:get/get.dart";
import "package:frontend/Widgets/AppColors.dart";
import "package:frontend/Widgets/CustomTextField.dart";
import "package:frontend/Widgets/CustomBottomNavBar.dart";
import "package:frontend/Controller/Auth_controller.dart";
import "package:frontend/Screens/authscreen/LoginScreen.dart";

class TeacherHomeScreen extends StatefulWidget {
  const TeacherHomeScreen({super.key});

  @override
  State<TeacherHomeScreen> createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends State<TeacherHomeScreen> {
  final HalaqatController halaqatController = Get.find();
  final StudentController studentController = Get.find();
  final UserController userController = Get.find();
  final AuthController authController = Get.find();
  final TextEditingController _categoryController = TextEditingController();
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
        Get.to(() => const LoginScreen());
        return;
      }

      if (halaqatController.currentHalaqah.value == null) {
        halaqatController.gethalaqahbyteacherid(user.Id);
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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // يخليه فوق المحتوى
        statusBarIconBrightness: Brightness.light, // لون الأيقونات
        statusBarBrightness: Brightness.dark, // iOS
      ),
      child: 
     Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Obx(
          () => Appbarcontainer(
            title:
            
                'حلقة: ${halaqatController.currentHalaqah.value?.Name ?? ""}',
            undertitel: 'المدرس: ${userController.getuserbyfirstandlastname()}',
)),
          ),
        
      backgroundColor: Appcolors.background,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/appbackground.jpg"),
            fit: BoxFit.cover,
            opacity: 0.15, // Reduced opacity for cleaner background
          ),
          //color: Appcolors.appBarbackground.withOpacity(0.5),
        ),
        child: Column(
          children: [
            // Simplified, Crisp Header Section
            Expanded(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Obx(() {
                  final halaqah = halaqatController.currentHalaqah.value;

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      boxShadow: Appcolors.glossyShadow,
                    ),
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                        child: Stack(
                          children: [
                            // Content Layer
                            Positioned.fill(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: const DecorationImage(
                                          image: AssetImage(
                                            "assets/images/appbackground.jpg",
                                          ),
                                          fit: BoxFit.cover,
                                          opacity: 0.5,
                                        ),
                                        color: Colors.white.withOpacity(0.75),
                                        border: Border.all(
                                          color: Appcolors.appmaincolor
                                              .withOpacity(0.4),
                                          width: 1.5,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.05),
                                            blurRadius: 20,
                                            offset: const Offset(0, 10),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "قائمة الطلاب",
                                                style: TextStyle(
                                                  color: Appcolors.appmaincolor,
                                                  fontSize: 17,
                                                  fontFamily: 'cairo',
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 12),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 5,
                                                child: CustomTextField(
                                                  controller: _searchController,
                                                  hintText: "بحث عن طالب...",
                                                  prefixIcon: Icons.search,
                                                  labelText: "بحث عن طالب",
                                                  fillColor: Colors.white,
                                                  textColor: Colors.black87,
                                                  iconColor:
                                                      Appcolors.appmaincolor,
                                                  borderColor: Appcolors
                                                      .appmaincolor
                                                      .withOpacity(0.15),
                                                  onChanged: (value) {
                                                    final halaqahId =
                                                        halaqatController
                                                            .currentHalaqah
                                                            .value
                                                            ?.Id;
                                                    if (halaqahId != null) {
                                                      studentController
                                                          .searchStudentsOnServer(
                                                            value,
                                                            halaqahId,
                                                          );
                                                    }
                                                  },
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              _buildFlatFilterButton(),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          _buildFilteringSection(),
                                          const SizedBox(height: 10),
                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              child: _buildStudentListView()),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            // Integrated Flush Navigation Bar
            Custombottomnavbar(centerbutton: 'add', currentpage: 'Home'),
          ],
        ),
      ),
     )
    );
  }

  Widget _buildFlatFilterButton() {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: Appcolors.appmaincolor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: PopupMenuButton<String>(
        padding: EdgeInsets.zero,
        icon: Icon(Icons.tune, color: Appcolors.appmaincolor, size: 22),
        onSelected: (value) => studentController.setFilterType(value),
        itemBuilder: (context) => [
          const PopupMenuItem(value: 'status', child: Text('بحسب الحالة')),
          const PopupMenuItem(value: 'category', child: Text('بحسب الفئة')),
        ],
      ),
    );
  }

  Widget _buildFilteringSection() {
    return Obx(() {
      final halaqahId = halaqatController.currentHalaqah.value?.Id;
      if (halaqahId == null) return const SizedBox.shrink();

      switch (studentController.filterType.value) {
        case "status":
          return Dropdown(
            items: const ["الكل", "مستمر", "متوقف"],
            value: studentController.selectedStatus.value,
            hintText: 'الحالة',
            label: 'تصفية الحالة',
            icon: Icons.person_outline,
            fillColor: Colors.white,
            onChanged: (value) =>
                studentController.searchStudentsByStatusAndHalaqatId(
                  value == "الكل" ? "" : value.toString(),
                  halaqahId,
                ),
          );
        case "category":
          return Dropdown(
            items: const [
              "اطفال",
              "أقل من 5 أجزاء",
              "5 أجزاء",
              "10 أجزاء",
              "15 جزء",
              "20 جزء",
              "25 جزء",
              "المصحف كامل",
            ],
            value: studentController.selectedCategory.value.isEmpty
                ? null
                : studentController.selectedCategory.value,
            hintText: 'الفئة',
            label: 'تصفية الفئة',
            icon: Icons.category,
            fillColor: Colors.white,
            onChanged: (value) {
              _categoryController.text = value.toString();
              studentController.searchStudentsByCategoryOnServer(
                value.toString(),
                halaqahId,
              );
            },
          );
        default:
          return const SizedBox.shrink();
      }
    });
  }

  Widget _buildStudentListView() {
    return Obx(() {
      final students = studentController.filteredStudents;
      if (studentController.isStudentsLoading.value) {
        return Center(
          child: CircularProgressIndicator(color: Appcolors.appmaincolor),
        );
      }

      if (students.isEmpty) {
        return _buildEmptyState();
      }

      return ListView.builder(
        key: const PageStorageKey('student_list_v2'),
        padding: const EdgeInsets.only(bottom: 20),
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return _buildStudentCard(student, index);
        },
      );
    });
  }

  Widget _buildEmptyState() {
    String message = "لا يوجد طلاب حالياً";
    IconData icon = Icons.person_off_outlined;

    if (_searchController.text.isNotEmpty) {
      message = "لا يوجد طلاب بهذا الاسم";
      icon = Icons.search_off;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 60, color: Appcolors.appmaincolor.withOpacity(0.2)),
          const SizedBox(height: 12),
          Text(
            message,
            style: TextStyle(
              color: Appcolors.appmaincolor,
              fontSize: 16,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentCard(dynamic student, int index) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: InkWell(
              onTap: () {
                studentController.setSelectedStudent(student);
                Get.to(() => StudentInfoScreen());
                print(student.current_Revision_Sorah);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Appcolors.appBarbackground.withOpacity(0.9),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Container(
                        width: 35,
                        alignment: Alignment.center,
                        child: Text(
                          (index + 1).toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.white.withOpacity(0.2),
                        thickness: 1,
                        indent: 5,
                        endIndent: 5,
                      ),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.white,
                        backgroundImage:
                            student.ImageUrl != null &&
                                student.ImageUrl!.isNotEmpty
                            ? NetworkImage(student.ImageUrl!)
                            : null,
                        child:
                            student.ImageUrl == null ||
                                student.ImageUrl!.isEmpty
                            ? Icon(
                                Icons.person,
                                color: Appcolors.appBarbackground,
                                size: 24,
                              )
                            : null,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              student.Name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text(
                              'الحفظ الحالي: ${student.current_Memorization_Sorah} (${student.current_Memorization_Aya})',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                                fontFamily: 'Cairo',
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Icon(
                        Icons.arrow_circle_left,
                        color: Colors.white,
                        size: 32,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
        ),
        const SizedBox(height: 10),
      ],
    );
    // return Padding(
    //   padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
    //   child: InkWell(
    //     borderRadius: BorderRadius.circular(18),
    //     onTap: () {
    //       studentController.setSelectedStudent(student);
    //       Get.to(() => StudentInfoScreen());
    //     },
    //     child: Container(
    //       decoration: BoxDecoration(
    //         color: Colors.white,
    //         borderRadius: BorderRadius.circular(18),
    //         boxShadow: [
    //           BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
    //         ],
    //         border: Border.all(color: Appcolors.appBarbackground.withOpacity(0.06)),
    //       ),
    //       child: ListTile(
    //         contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
    //         leading: Stack(
    //           children: [
    //             CircleAvatar(
    //               radius: 24,
    //               backgroundColor: Appcolors.appBarbackground.withOpacity(0.08),
    //               backgroundImage: student.ImageUrl != null && student.ImageUrl!.isNotEmpty ? NetworkImage(student.ImageUrl!) : null,
    //               child: student.ImageUrl == null || student.ImageUrl!.isEmpty
    //                   ? Icon(Icons.person, color: Appcolors.appBarbackground, size: 28)
    //                   : null,
    //             ),
    //             Positioned(
    //               bottom: 2,
    //               right: 2,
    //               child: Container(
    //                 width: 13,
    //                 height: 13,
    //                 decoration: BoxDecoration(
    //                   color: statusColor,
    //                   shape: BoxShape.circle,
    //                   border: Border.all(color: Colors.white, width: 2)
    //                 )
    //               )
    //             ),
    //           ],
    //         ),
    //         title: Text(
    //           student.Name,
    //           style: const TextStyle(
    //             fontFamily: 'Cairo',
    //             fontWeight: FontWeight.w700,
    //             fontSize: 15
    //           )
    //         ),
    //         subtitle: Text(
    //           "ما وصل اليه : ${student.current_Memorization_Sorah}",
    //           style: TextStyle(
    //             fontFamily: 'Cairo',
    //             fontSize: 12,
    //             color: Colors.grey.shade600
    //           )
    //         ),
    //         trailing: Container(
    //           padding: const EdgeInsets.all(8),
    //           decoration: BoxDecoration(
    //             color: Appcolors.appmaincolor.withOpacity(0.08),
    //             shape: BoxShape.circle,
    //           ),
    //           child: Icon(Icons.arrow_forward_ios, color: Appcolors.appmaincolor, size: 14),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
