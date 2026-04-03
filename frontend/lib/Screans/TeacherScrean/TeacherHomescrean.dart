import "package:flutter/material.dart";
import "package:frontend/Controller/UserController.dart";
import "package:frontend/Controller/HalaqatController.dart";
import "package:frontend/Controller/StudentController.dart";
import "package:frontend/Screans/generalscrean/LoginScrean.dart";
import "package:get/get.dart";
import "package:frontend/Widgets/AppColors.dart";
import "package:frontend/Widgets/CustomTextField.dart";
import "package:frontend/Screans/TeacherScrean/Studentinfo.dart";

class TeacherHomescrean extends StatelessWidget {
  TeacherHomescrean({super.key});

  final HalaqatController halaqatController = Get.put(HalaqatController());
  final StudentController studentController = Get.put(StudentController());
  final UserController userController = Get.put(UserController());
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // Trigger data fetching when the screen is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // إذا لم تكن الحلقة محملة، أو إذا كانت محملة ولكن قائمة الطلاب لا تزال فارغة
      if (!halaqatController.isLoading.value) {
        if (halaqatController.currentHalaqah.value == null) {
          halaqatController.gethalaqahbyteacherid(
            userController.currentUser.value!.Id,
          );
        } else if (studentController.students.isEmpty &&
            !studentController.isStudentsLoading.value) {
          studentController.getStudentsByHalaqahId(
            halaqatController.currentHalaqah.value!.Id,
          );
        }
      }
    });

    return Scaffold(
      backgroundColor: Appcolors.background,
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
              Get.offAll(() => Loginscrean());
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            // Styled Header Section
            
              Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 25),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Appcolors.appBarbackground,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(" "),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "مرحبا ${userController.currentUser.value?.Name ?? ""}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                          ),
                        ),
                        Text(
                          "المهنة : ${userController.currentUser.value?.Role ?? ""}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ],
                    ),
                    Divider(color: Colors.white, thickness: 1),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "اسم الحلقة : ${halaqatController.currentHalaqah.value?.Name ?? ""}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                            ),
                          ),
                          Text(
                            "عدد الطلاب : ${studentController.students.length}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 10),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(
                    255,
                    182,
                    226,
                    183,
                  ).withOpacity(0.3),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  border: Border.all(
                    color: Appcolors.appBarbackground.withOpacity(0.2),
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      "قائمة الطلاب",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                        fontFamily: 'Cairo',
                      ),
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      controller: _searchController,
                      hintText: "بحث عن طالب...",
                      prefixIcon: Icons.search,
                      fillColor: Colors.white,
                      textColor: Colors.black87,
                      iconColor: Appcolors.appBarbackground,
                      borderColor: Appcolors.appBarbackground.withOpacity(0.3),
                      onChanged: (value) =>
                          studentController.searchStudents(value),
                    ),
                    const SizedBox(height: 15),
                    Expanded(
                      child: Obx(() {
                        final students = studentController.filteredStudents;
                        if (students.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search_off,
                                  size: 60,
                                  color: Colors.grey[300],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "لم يتم العثور على طلاب",
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return ListView.builder(
                          itemCount: students.length,
                          itemBuilder: (context, index) {
                            final student = students[index];
                            Color statusColor = student.status == "مستمر"
                                ? Colors.green
                                : Colors.orange;

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 2,
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () {
                                  // Details view
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
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 10,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                    border: Border.all(
                                      color: Appcolors.appBarbackground
                                          .withOpacity(0.15),
                                    ),
                                  ),
                                  child: ListTile(
                                    dense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 0,
                                    ),

                                    /// 🔹 الصورة + الحالة
                                    leading: Stack(
                                      children: [
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Appcolors
                                              .appBarbackground
                                              .withOpacity(0.08),
                                          backgroundImage:
                                              student.ImageUrl != null &&
                                                  student.ImageUrl!.isNotEmpty
                                              ? NetworkImage(student.ImageUrl!)
                                              : null,
                                          child:
                                              student.ImageUrl == null ||
                                                  student.ImageUrl!.isEmpty
                                              ? Text(
                                                  student.Name.isNotEmpty
                                                      ? student.Name[0]
                                                            .toUpperCase()
                                                      : "?",
                                                  style: TextStyle(
                                                    color: Appcolors
                                                        .appBarbackground,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                )
                                              : null,
                                        ),

                                        /// 🔥 نقطة الحالة
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

                                    /// 🔹 الاسم
                                    title: Text(
                                      student.Name,
                                      style: const TextStyle(
                                        fontFamily: 'Cairo',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),

                                    /// 🔹 المعرف
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Text(
                                        "ما وصل اليه : ${student.current_Memorization_Sorah}",
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 15,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ),

                                    
                                    trailing: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: Appcolors.appBarbackground
                                            .withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
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
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(Icons.home, "الرئيسية", true),
            Transform.translate(
              offset: const Offset(0, -15),
              child: _buildAddButton(),
            ),
            _buildNavItem(Icons.person, "الملف", false),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, IconData icon) {
    bool isSelected = studentController.selectedStatus.value == label;
    return GestureDetector(
      onTap: () => studentController.setStatusFilter(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Appcolors.appBarbackground : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Appcolors.appBarbackground : Colors.grey[300]!,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Appcolors.appBarbackground.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? Colors.white : Colors.grey[600],
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[600],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected) {
    return InkWell(
      onTap: () {},
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
    return Container(
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
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 35,
      ),
    );
  }
}
