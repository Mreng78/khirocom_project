import 'package:frontend/Screens/authscreen/LoginScreen.dart';
import "package:get/get.dart";

class SplashScreenController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    goToStartScreen();
  }

  void goToStartScreen() async {
    await Future.delayed(Duration(seconds: 1));
    Get.offAll(() => LoginScreen());
  }
}