import 'package:http/http.dart' as http;
import 'dart:convert';

class Dailyprogressservice {
  static const String dailyprogressbaseurl =
      "http://192.168.0.3:8000/api/dailyprogress";

  static Future<Map<String, dynamic>> adddailyprogress(
    Map<String, dynamic> dailyprogressdata,
  ) async {
    try {
      final uri = Uri.parse('$dailyprogressbaseurl/add');
      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(dailyprogressdata),
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
        return {"success": true, "message": "تم إضافة التقدم اليومي بنجاح", "data": responsebody['data']};
      } else {
        return {
          "success": false,
          "message": responsebody['message'] ?? responsebody['error'] ?? "فشل العملية"
        };
        print(responsebody['message']);
      }
    } catch (e) {
      print(e);
      return {"success": false, "message": "خطأ في الاتصال بالسيرفر: $e"};
    }
  }

  static Future<Map<String, dynamic>> getdailyprogressbystudentid(int studentId) async {
    try {
      final uri = Uri.parse('$dailyprogressbaseurl/getbystudentid');
      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          // Note: Add auth header here if token management is implemented
        },
        body: jsonEncode({"id": studentId}),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> responsebody = jsonDecode(response.body);
        return {"success": true, "data": responsebody};
      } else {
        final responsebody = jsonDecode(response.body);
        return {
          "success": false,
          "message": responsebody['message'] ?? "فشل جلب البيانات"
        };
      }
    } catch (e) {
      return {"success": false, "message": "خطأ في الاتصال بالسيرفر: $e"};
    }
  }

  static Future<Map<String, dynamic>> getallmonthyearnames(
    int studentid,
  ) async {
    try {
      final uri = Uri.parse('$dailyprogressbaseurl/getallmonthyearnames');
      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({"StudentId": studentid}),
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
        return {"success": true, "message": responsebody['message'], "data": responsebody['data']};
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

    static Future<Map<String, dynamic>> getallmonthyearhistory(
    int studentid,
    String monthyear,
  ) async {
    try {
      final uri = Uri.parse('$dailyprogressbaseurl/getallmonthyearhistory');
      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({"StudentId": studentid, "Month_year": monthyear}),
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
        return {"success": true, "message": responsebody['message'], "data": responsebody['data']};
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
