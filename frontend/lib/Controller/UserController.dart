import 'package:frontend/models/Student.model.dart';
import 'package:get/get.dart';
import '../models/User.model.dart';
import '../Services/UserServivices.dart';

class UserController extends GetxController {
  final UserbaseUrl = 'http://192.168.0.3:8000/api/users';

  final RxList<User> users = <User>[].obs;
  final Rx<User?> currentUser = Rx<User?>(null);
  final RxBool isLoading = RxBool(false);
  final RxString errorMessage = RxString('');
  final RxBool isLoggedIn = RxBool(false);
  final RxString Role = RxString('');
  final Rx<Student?> currentStudent = Rx<Student?>(null);

  // Future<bool> login(String usernameOrPhoneNumber, String password) async {
  //   isLoading.value = true;
  //   errorMessage.value = '';
  //   Role.value = '';
  //   try {
  //     final Map<String, dynamic> result = await UserServices.login(usernameOrPhoneNumber, password);
  //     print("Received Login result: $result");
      
  //     if (result["success"] == true && (result["Role"] == "مدرس" || result["Role"] == "admin" || result["Role"] == "مشرف")) {
  //       Role.value = result["Role"];
  //       final Map<String, dynamic> responseData = result["userData"];
        
  //       final Map<String, dynamic> userData = responseData["user"] ?? responseData["student"] ?? {};
  //       final User user = User.fromJson(userData);
        
  //       currentUser.value = user;
  //       isLoggedIn.value = true;
  //       return true;
  //     }
  //     else if (result["success"] == true && result["Role"] == "طالب") {
  //       Role.value = "طالب";
  //       final Map<String, dynamic> responseData = result["userData"];
        
  //       final Map<String, dynamic> userData = responseData["user"] ?? responseData["student"] ?? {};
  //       final Student student = Student.fromJson(userData);
        
  //       currentStudent.value = student;
  //       isLoggedIn.value = true;
  //       return true;
  //     } else {
  //       errorMessage.value = result["message"] ?? "بيانات الدخول غير صحيحة (Role: ${result["Role"]})";
  //       return false;
  //     }
  //   } catch (e) {
  //     errorMessage.value = "حدث خطأ أثناء معالجة البيانات: $e";
  //     print(e);
  //     return false;
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
  // Future<void> logout() async {
  //   currentUser.value = null;
  // }
}
