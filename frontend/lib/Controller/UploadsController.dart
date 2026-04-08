import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../Services/uploads.service.dart';

class UploadsController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  final RxString uploadedImageUrl = "".obs;
  final RxBool isUploading = false.obs;
  final RxString errorMessage = "".obs;

  /// Picks an image from the gallery and uploads it.
  Future<String?> pickAndUploadImage() async {
    try {
      errorMessage.value = "";
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80, // Optional: compress the image
      );

      if (image != null) {
        isUploading.value = true;
        
        final result = await UploadsService.uploadImage(image.path);
        
        if (result["success"] == true) {
          uploadedImageUrl.value = result["imageUrl"] ?? "";
          return uploadedImageUrl.value;
        } else {
          errorMessage.value = result["message"] ?? "فشل رفع الصورة";
          return null;
        }
      }
      return null;
    } catch (e) {
      errorMessage.value = "حدث خطأ أثناء اختيار أو رفع الصورة: $e";
      return null;
    } finally {
      isUploading.value = false;
    }
  }

  void clearUploads() {
    uploadedImageUrl.value = "";
    errorMessage.value = "";
  }
}
