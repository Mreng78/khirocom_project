import 'package:frontend/Services/AuthService.dart';
import "package:get/get.dart";
import 'package:get_storage/get_storage.dart';
import '../models/User.model.dart';
import '../models/Student.model.dart';


class AuthController extends GetxController {
  final UserbaseUrl = 'http://192.168.0.3:8000/api/users';

  final RxBool isLoading = RxBool(false);
  final RxString errorMessage = RxString('');
  final RxBool isLoggedIn = RxBool(false);
  final RxString Role = RxString('');
  final Rx<User?> currentUser = Rx<User?>(null);
  final Rx<Student?> currentStudent = Rx<Student?>(null);
  final RxBool obscurePassword = RxBool(false);

  final box = GetStorage();
  var isoflineMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    isoflineMode.value = box.read("offline") ?? false;
  }
  void toggleOfflineMode(bool val)
  {
    isoflineMode.value=val;
    box.write("offline", val);
    if(val)
    {
      print(".........");
    }
  }
  
  Future<bool> login(String usernameOrPhoneNumber, String password) async {
    isLoading.value = true;
    errorMessage.value = '';
    Role.value = '';
    try {
      final Map<String, dynamic> result = await AuthService.login(usernameOrPhoneNumber, password);
      print("Received Login result: $result");
      
      if (result["success"] == true && (result["Role"] == "مدرس" || result["Role"] == "admin" || result["Role"] == "مشرف")) {
        Role.value = result["Role"];
        final Map<String, dynamic> responseData = result["userData"];
        
        final Map<String, dynamic> userData = responseData["user"] ?? responseData["student"] ?? {};
        final User user = User.fromJson(userData);
        
        currentUser.value = user;
        isLoggedIn.value = true;
        return true;
      }
      else if (result["success"] == true && result["Role"] == "طالب") {
        Role.value = "طالب";
        final Map<String, dynamic> responseData = result["userData"];
        
        final Map<String, dynamic> userData = responseData["user"] ?? responseData["student"] ?? {};
        final Student student = Student.fromJson(userData);
        
        currentStudent.value = student;
        isLoggedIn.value = true;
        return true;
      } else {
        errorMessage.value = result["message"] ?? "بيانات الدخول غير صحيحة (Role: ${result["Role"]})";
        return false;
      }
    } catch (e) {
      errorMessage.value = "حدث خطأ أثناء معالجة البيانات: $e";
      print(e);
      return false;
    } finally {
      isLoading.value = false;
    }
  }
  
  void user_logout() {
    currentUser.value = null;
    isLoggedIn.value = false;
    Role.value = '';
  }

  void student_logout() {
    currentStudent.value = null;
    isLoggedIn.value = false;
    Role.value = '';
  }
  void toggleObscurePassword() {
    obscurePassword.value = !obscurePassword.value;
  }
}
