import 'package:get/get.dart';
import '../Controller/StudentController.dart';

class StudentInfoScreanController extends GetxController {

  final StudentController studentController = Get.put(StudentController());
  final RxString selectedwindow = "البيانات".obs;
   
   
  void changeWindow(String value) {
    selectedwindow.value = value;
  }
  
  
}