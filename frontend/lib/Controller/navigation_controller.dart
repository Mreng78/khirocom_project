import 'package:get/get.dart';

class NavigationController extends GetxController {
  final List<String> pages=[
    "Home",
    "activities",
    "profile",
    "settings",
    "record",
    "add_student",
    "student_info"
  ];

  final RxString page = "Home".obs;
  
  void changePage(String newPage) {
    page.value = newPage;
  }
}