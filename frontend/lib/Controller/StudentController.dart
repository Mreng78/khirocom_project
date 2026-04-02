import 'package:get/get.dart';
import '../models/Student.model.dart';
import '../Services/StudentServices.dart';

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

  void clearStudents() {
    students.clear();
  }
}