import "package:get/get.dart";
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
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
}
