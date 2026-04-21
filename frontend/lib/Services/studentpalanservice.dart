
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend/models/StudentPlane.model.dart';

class StudentPlanService {
  final String baseUrl = "http://192.168.0.3:8000/api/studentplan";

  Future<Map<String, dynamic>> addstudentplan(Map<String, dynamic> studentPlan) async {
     try {
      final uri = Uri.parse('${baseUrl}/addstudentplan');
      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(studentPlan),
      ).timeout(const Duration(seconds: 10));

      final contentType = response.headers['content-type'];
      if (contentType == null || !contentType.contains('application/json')) {
        return {
          "success": false,
          "message":
              "السيرفر أرجع استجابة غير صالحة. تأكد من عمل السيرفر وصحة الرابط: $uri",
        };
      }
      final responsebody = jsonDecode(response.body);
      if (responsebody['success'] == true) {
        return {"success": true, "message": "تم إضافة الخطة بنجاح", "data": responsebody['data']};
      } else {
        return {
          "success": false,
          "message": responsebody['message'] ?? responsebody['error'] ?? "فشل العملية"
        };
      }
    } catch (e) {
      print(e);
      return {"success": false, "message": "خطأ في الاتصال بالسيرفر: $e"};
    }
  }
}
