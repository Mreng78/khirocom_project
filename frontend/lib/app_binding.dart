import 'package:get/get.dart';
import 'package:frontend/Controller/StudentController.dart';
import 'package:frontend/Controller/Auth_controller.dart';
import 'package:frontend/Controller/UploadsController.dart';
import 'package:frontend/Controller/StudentInfoScreenController.dart';
import 'package:frontend/Controller/SurahController.dart';
import 'package:frontend/Controller/HalaqatController.dart';
import 'package:frontend/Controller/navigation_controller.dart';
import 'package:frontend/Controller/SplashScreenController.dart';
import 'package:frontend/Controller/UserController.dart';
import 'package:frontend/Controller/DailyProgresscontroller.dart';
import 'package:frontend/Controller/StudentPlancontroller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StudentController(), permanent: true);
    Get.put(AuthController(), permanent: true);
    Get.put(UploadsController(), permanent: true);
    Get.put(StudentInfoScreenController(), permanent: true);
    Get.put(SurahController(), permanent: true);
    Get.put(HalaqatController(), permanent: true);
    Get.put(NavigationController(), permanent: true);
    Get.put(SplashScreenController(), permanent: true);
    Get.put(UserController(), permanent: true);
    Get.put(Dailyprogresscontroller(), permanent: true);
    Get.put(StudentPlanController(), permanent: true);
  }
}
