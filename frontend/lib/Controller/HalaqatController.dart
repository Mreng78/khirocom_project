import 'package:get/get.dart';
import 'package:frontend/models/Halakat.model.dart';
import 'package:frontend/Controller/StudentController.dart';
import 'package:frontend/Services/HalaqatServices.dart';

class HalaqatController extends GetxController {
  final RxList<Halakat> halaqat = <Halakat>[].obs;
  final Rx<Halakat?> currentHalaqah = Rx<Halakat?>(null);
  final RxString errorMessage = RxString('');
  final RxBool isLoading = RxBool(false);

  // Injecting or getting the student controller instance
  final StudentController studentController = Get.find<StudentController>();

  @override
  void onInit() {
    super.onInit();
    print("--- HalaqatController Initialized ---");
    // Placeholder fetching, actual fetch is triggered in the view or here if needed
    // gethalaqahbyteacherid(7); 
  }

  Future<bool> gethalaqahbyteacherid(int id) async {
    print("--- START: gethalaqahbyteacherid for ID: $id ---");
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final Map<String, dynamic> result = await HalaqatServices.gethalaqahbyteacherid(id);
      print("API Raw Result: $result");
      
      if (result["success"] == true) {
        final dynamic data = result["data"]["halaqat"];
        print("Extracted Halaqat Data: $data");
        
        if (data is List) {
          halaqat.assignAll(data.map((json) => Halakat.fromJson(json)).toList());
          if (halaqat.isNotEmpty) {
            currentHalaqah.value = halaqat.first;
            print("Multiple halaqat found, selecting first: ${currentHalaqah.value!.Name}");
            await studentController.getStudentsByHalaqahId(currentHalaqah.value!.Id);
          }
        } else if (data is Map<String, dynamic>) {
          final h = Halakat.fromJson(data);
          halaqat.assignAll([h]);
          currentHalaqah.value = h;
          print("Single halaqah found and set: ${h.Name} (ID: ${h.Id})");
          await studentController.getStudentsByHalaqahId(h.Id);
        }
        return true;
      } else {
        errorMessage.value = result["message"] ?? "فشل في جلب البيانات";
        print("API reported failure: ${errorMessage.value}");
        return false;
      }
    } catch (e, stack) {
      print("CRITICAL ERROR in gethalaqahbyteacherid: $e");
      print(stack);
      return false;
    } finally {
      isLoading.value = false;
      print("--- END: gethalaqahbyteacherid ---");
    }
  }

  void selectHalaqah(Halakat h) {
    currentHalaqah.value = h;
    studentController.getStudentsByHalaqahId(h.Id);
  }
}