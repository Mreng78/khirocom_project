import 'dart:convert';
import 'package:http/http.dart' as http;

class UploadsService {
  static const String UploadsBaseUrl = "http://192.168.0.3:8000/api/uploads/";

  /// Uploads an image to the server and returns the response.
  /// [imagePath] is the local path of the image file.
  static Future<Map<String, dynamic>> uploadImage(String imagePath) async {
    try {
      final uri = Uri.parse('${UploadsBaseUrl}upload');
      
      // Create multipart request
      var request = http.MultipartRequest('POST', uri);
      
      // Add the file to the request
      request.files.add(
        await http.MultipartFile.fromPath(
          'image', // This should match the field name expected by your backend
          imagePath,
        ),
      );

      // Send the request
      var streamedResponse = await request.send();
      
      // Get the response and check body
      var response = await http.Response.fromStream(streamedResponse);
      
      print("Upload Response Status: ${response.statusCode}");
      print("Upload Response Body: ${response.body}");

      if (!response.headers['content-type']!.contains('application/json')) {
        return {
          "success": false,
          "message": "السيرفر أرجع استجابة غير صالحة (HTML). تأكد من صحة الرابط: $uri"
        };
      }

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          "success": true,
          "message": "تم رفع الصورة بنجاح",
          "imageUrl": responseData["imageUrl"] ?? responseData["url"] ?? "", // Return the URL from backend
          "data": responseData
        };
      } else {
        print("Backend returned status code: ${response.statusCode}");
        print("Backend response data: $responseData");
        return {
          "success": false,
          "message": responseData["message"] ?? responseData["error"] ?? "فشل رفع الصورة"
        };
      }
    } catch (e) {
      print("Error in uploadImage: $e");
      return {
        "success": false,
        "message": "خطأ في الاتصال بالسيرفر أثناء رفع الصورة: $e"
      };
    }
  }
}
