import "package:http/http.dart" as http;
import "dart:convert";
import "../models/Student.model.dart";

class StudentServices {
  static const String StudentBaseUrl = "http://192.168.0.3:8000/api/students/";

  static Future<Map<String,dynamic>> getallstudentsbyhalaqahid (int Id) async
  {
    try
    {
      final uri = Uri.parse('${StudentBaseUrl}getallstudentsbyhalaqahid');
      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json", 
          "Accept": "application/json",
        },
        body: jsonEncode({
          "Id": Id,
        }),
      );
      
      final responseData = jsonDecode(response.body);  
      
      if (response.statusCode == 200) {
        // Find Role inside user data if not at the root level
        String? role = responseData["Role"];
        if (role == null && responseData["user"] != null) {
          role = responseData["user"]["Role"];
        }

        return {
          "Role": role,
          "success": true, 
          "userData": responseData 
        };
      } else {
        print("Backend returned non-200 status code: ${response.statusCode}");
        print("Backend response data: $responseData");
        return {
          "success": false, 
          "message": responseData["message"] ?? responseData["error"] ?? "بيانات الدخول غير صحيحة"
        };
      }
    } catch (e) {
   print(e);
      return {
        "success": false, 
        "message": "خطأ في الاتصال بالسيرفر: $e"
      };
     
    }
  }
}