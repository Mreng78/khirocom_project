import "package:get/get.dart";
import '../Screans/authscrean/LoginScrean.dart';


class Splashscreancontroller extends GetxController {
  @override
  void onReady()
  {
    super.onReady();
    gotostartscrean();
  }
  void gotostartscrean () async
  {
    await Future.delayed(Duration(seconds: 1));
    Get.offAll(()=>Loginscrean());
  }
}