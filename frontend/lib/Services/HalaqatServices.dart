import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/Halakat.model.dart';

class HalaqatServices {
  static const String HalaqatBaseUrl = "http://192.168.0.3:8000/api/halaqat/";

  static Future<Map<String, dynamic>> gethalaqahbyteacherid(int Id) async {
    try {
      final uri = Uri.parse('${HalaqatBaseUrl}gethalaqahbyteacherid');
      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({"TeacherId": Id}),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {"success": true, "data": responseData};
      } else {
        return {
          "success": false, 
          "message": responseData["message"] ?? "فشل في جلب البيانات (${response.statusCode})"
        };
      }
    } catch (e) {
      print(e);
      return {"success": false, "message": "خطأ في الاتصال بالسيرفر: $e"};
    }
  }
}
