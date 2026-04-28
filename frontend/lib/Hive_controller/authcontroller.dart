import 'package:get/get.dart';
import 'package:hive/hive.dart';

class AuthController extends GetxController {
  late Box box;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    box = Hive.box('auth');
  }
}
