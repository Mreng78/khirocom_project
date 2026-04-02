import "package:get/get.dart";
import '../Screans/generalscrean/LoginScrean.dart';


class Splashscreancontroller extends GetxController {
  @override
  void onReady()
  {
    super.onReady();
    gotostartscrean();
  }
  void gotostartscrean () async
  {
    await Future.delayed(Duration(seconds: 3));
    Get.offAll(()=>Loginscrean());
  }
}