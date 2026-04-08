import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/Student.model.dart';
import '../Services/StudentServices.dart';
import '../Widgets/AppColors.dart';
import '../Controller/HalaqatController.dart';


class StudentController extends GetxController {
  final RxList<Student> students = <Student>[].obs;
  final RxBool isStudentsLoading = RxBool(false);
  final RxString errorMessage = RxString('');
  final RxString searchQuery = RxString('');
  final RxString selectedStatus = RxString('الكل');

  List<Student> get filteredStudents {
    List<Student> filtered = students;

    // Filter by status if not "الكل"
    if (selectedStatus.value != 'الكل') {
      filtered = filtered.where((student) => 
        student.status.toLowerCase() == selectedStatus.value.toLowerCase()
      ).toList();
    }

    // Filter by search query
    if (searchQuery.value.isNotEmpty) {
      filtered = filtered.where((student) => 
        student.Name.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
        student.Username.toLowerCase().contains(searchQuery.value.toLowerCase())
      ).toList();
    }

    return filtered;
  }

  void searchStudents(String query) {
    searchQuery.value = query;
  }

  void setStatusFilter(String status) {
    selectedStatus.value = status;
  }

  Future<void> getStudentsByHalaqahId(int halaqahId) async {
    print("--- START: getStudentsByHalaqahId for ID: $halaqahId ---");
    isStudentsLoading.value = true;
    errorMessage.value = '';
    try {
      final Map<String, dynamic> result = await StudentServices.getallstudentsbyhalaqahid(halaqahId);
      print("Students API Result: $result");
      
      if (result["success"] == true) {
        final List<dynamic> data = result["userData"]["students"] ?? [];
        print("Parsed students count: ${data.length}");
        students.assignAll(data.map((json) => Student.fromJson(json)).toList());
      } else {
        errorMessage.value = result["message"] ?? "فشل في جلب الطلاب";
        print("Students API failed: ${errorMessage.value}");
      }
    } catch (e, stack) {
      print("CRITICAL ERROR in getStudentsByHalaqahId: $e");
      print(stack);
      errorMessage.value = "حدث خطأ غير متوقع: $e";
    } finally {
      isStudentsLoading.value = false;
      print("--- END: getStudentsByHalaqahId ---");
    }
  }

  Future<bool> addStudent(Map<String, dynamic> studentData) async {
    isStudentsLoading.value = true;
    errorMessage.value = '';
    try {
      final result = await StudentServices.addStudent(studentData);
      if (result["success"] == true) {
        // Refresh the student list automatically
        final halaqatController = Get.find<HalaqatController>();
        if (halaqatController.currentHalaqah.value != null) {
          await getStudentsByHalaqahId(halaqatController.currentHalaqah.value!.Id);
        }

        Get.snackbar("نجاح", "تمت إضافة الطالب بنجاح", 
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Appcolors.appmaincolor,
          colorText: Colors.white
        );
        return true;
      } else {
        errorMessage.value = result["message"] ?? "فشل في إضافة الطالب";
        Get.snackbar("خطأ", errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white
        );
        return false;
      }
    } catch (e) {
      errorMessage.value = "حدث خطأ غير متوقع: $e";
      return false;
    } finally {
      isStudentsLoading.value = false;
    }
  }

  Future<bool> updateStudent(int id, Map<String, dynamic> studentData) async {
    isStudentsLoading.value = true;
    errorMessage.value = '';
    try {
      final result = await StudentServices.updateStudent(id, studentData);
      if (result["success"] == true) {
        // Refresh the student list automatically
        final halaqatController = Get.find<HalaqatController>();
        if (halaqatController.currentHalaqah.value != null) {
          await getStudentsByHalaqahId(halaqatController.currentHalaqah.value!.Id);
        }

        Get.snackbar("نجاح", "تم تحديث بيانات الطالب بنجاح", 
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Appcolors.appmaincolor,
          colorText: Colors.white
        );
        return true;
      } else {
        errorMessage.value = result["message"] ?? "فشل في تحديث بيانات الطالب";
        Get.snackbar("خطأ", errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white
        );
        return false;
      }
    } catch (e) {
      errorMessage.value = "حدث خطأ غير متوقع: $e";
      return false;
    } finally {
      isStudentsLoading.value = false;
    }
  }

  Future<bool> dismissStudent(int id) async {
    isStudentsLoading.value = true;
    errorMessage.value = '';
    try {
      final result = await StudentServices.dismiss(id);
      if (result["success"] == true) {
        // Refresh the student list automatically
        final halaqatController = Get.find<HalaqatController>();
        if (halaqatController.currentHalaqah.value != null) {
          await getStudentsByHalaqahId(halaqatController.currentHalaqah.value!.Id);
        }

        Get.snackbar("نجاح", "تم حذف الطالب بنجاح", 
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Appcolors.appmaincolor,
          colorText: Colors.white
        );
        return true;
      } else {
        errorMessage.value = result["message"] ?? "فشل في حذف الطالب";
        Get.snackbar("خطأ", errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white
        );
        return false;
      }
    } catch (e) {
      errorMessage.value = "حدث خطأ غير متوقع: $e";
      return false;
    } finally {
      isStudentsLoading.value = false;
    }
  }

  void clearStudents() {

    students.clear();
  }

  Future<void> searchStudentsOnServer(String name, int halaqatId) async {
    if (name.isEmpty) {
      // If search query is empty, reload all students for this halaqah
      await getStudentsByHalaqahId(halaqatId);
      return;
    }

    isStudentsLoading.value = true;
    try {
      final result = await StudentServices.getStudentsByNameAndHalaqatId(name, halaqatId);
      if (result["success"] == true) {
        final List<dynamic> data = result["students"] ?? [];
        students.assignAll(data.map((json) => Student.fromJson(json)).toList());
      } else {
        print("Search failed: ${result["message"]}");
        // Optionally clear the list or keep old results
        // students.clear(); 
      }
    } catch (e) {
      print("Search controller error: $e");
    } finally {
      isStudentsLoading.value = false;
    }
  }
}