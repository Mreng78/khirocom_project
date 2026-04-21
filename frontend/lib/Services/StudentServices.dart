import "package:http/http.dart" as http;
import "dart:convert";

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

  static Future<Map<String, dynamic>> addStudent(Map<String, dynamic> studentData) async {
    try {
      final uri = Uri.parse('${StudentBaseUrl}addnewstudent');
      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(studentData),
      );

      print("Add Student Response Status: ${response.statusCode}");
      print("Add Student Response Body: ${response.body}");

      if (!response.headers['content-type']!.contains('application/json')) {
        return {
          "success": false,
          "message": "السيرفر أرجع استجابة غير صالحة (HTML). تأكد من وجود الرابط $uri في الباك اند."
        };
      }

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          "success": true,
          "message": "تمت إضافة الطالب بنجاح",
          "data": responseData
        };
      } else {
        return {
          "success": false,
          "message": responseData["message"] ?? responseData["error"] ?? "فشل في إضافة الطالب"
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

  static Future<Map<String, dynamic>> updateStudent(int id, Map<String, dynamic> studentData) async {
    try {
      final uri = Uri.parse('${StudentBaseUrl}updatestudent');
      final response = await http.put(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          ...studentData,
          "Id": id,
        }),
      );

      print("Update Student Response Status: ${response.statusCode}");
      print("Update Student Response Body: ${response.body}");

      if (!response.headers['content-type']!.contains('application/json')) {
        return {
          "success": false,
          "message": "السيرفر أرجع استجابة غير صالحة (HTML). تأكد من وجود الرابط $uri في الباك اند."
        };
      }

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          "success": true,
          "message": "تم تحديث بيانات الطالب بنجاح",
          "data": responseData
        };
      } else {
        return {
          "success": false,
          "message": responseData["message"] ?? responseData["error"] ?? "فشل في تحديث بيانات الطالب"
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

  static Future<Map<String, dynamic>> dismiss(int id) async {
    try {
      final uri = Uri.parse('${StudentBaseUrl}dismissstudent');
      final response = await http.put(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "Id": id,
        }),
      );

      print("Delete Student Response Status: ${response.statusCode}");
      print("Delete Student Response Body: ${response.body}");

      if (!response.headers['content-type']!.contains('application/json')) {
        return {
          "success": false,
          "message": "السيرفر أرجع استجابة غير صالحة (HTML). تأكد من وجود الرابط $uri في الباك اند."
        };
      }

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          "success": true,
          "message": "تم حذف الطالب بنجاح",
          "data": responseData
        };
      } else {
        return {
          "success": false,
          "message": responseData["message"] ?? responseData["error"] ?? "فشل في حذف الطالب"
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

  static Future<Map<String, dynamic>> getStudentsByNameAndHalaqatId(String name, int halaqatId) async {
    try {
      final uri = Uri.parse('${StudentBaseUrl}getstudentsbynameandhalaqatid');
      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "Name": name,
          "HalakatId": halaqatId,
        }),
      );

      print("Search API Response Status: ${response.statusCode}");
      print("Search API Response Body: ${response.body}");

      if (!response.headers['content-type']!.contains('application/json')) {
        return { "success": false, "message": "استجابة غير صالحة من السيرفر" };
      }

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          "success": true,
          "students": (responseData["students"] as List?) ?? [],
        };
      } else {
        return {
          "success": false,
          "message": responseData["message"] ?? "فشل في البحث"
        };
      }
    } catch (e) {
      print("Search API Error: $e");
      return { "success": false, "message": "خطأ في الاتصال: $e" };
    }
  }


  static Future<Map<String, dynamic>> getStudentsByStatusAndHalaqatId(String status, int halaqatId) async {
    try {
      final uri = Uri.parse('${StudentBaseUrl}getstudentsbystatusandhalakahid');
      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "status": status,
          "halakatid": halaqatId,
        }),
      );

      print("Search API Response Status: ${response.statusCode}");
      print("Search API Response Body: ${response.body}");

      if (!response.headers['content-type']!.contains('application/json')) {
        return { "success": false, "message": "استجابة غير صالحة من السيرفر" };
      }

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          "success": true,
          "students": (responseData["students"] as List?) ?? [],
        };
      } else {
        return {
          "success": false,
          "message": responseData["message"] ?? "فشل في البحث"
        };
      }
    } catch (e) {
      print("Search API Error: $e");
      return { "success": false, "message": "خطأ في الاتصال: $e" };
    }
  }

  static Future<Map<String, dynamic>> getStudentsByCategoryAndHalaqatId(String category, int halaqatId) async {
    try {
      final uri = Uri.parse('${StudentBaseUrl}getstudentsbycategoryandhalakahid');
      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "category": category,
          "halakatid": halaqatId,
        }),
      );

      print("Search API Response Status: ${response.statusCode}");
      print("Search API Response Body: ${response.body}");

      if (!response.headers['content-type']!.contains('application/json')) {
        return { "success": false, "message": "استجابة غير صالحة من السيرفر" };
      }

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          "success": true,
          "students": (responseData["students"] as List?) ?? [],
        };
      } else {
        return {
          "success": false,
          "message": responseData["message"] ?? "فشل في البحث"
        };
      }
    } catch (e) {
      print("Search API Error: $e");
      return { "success": false, "message": "خطأ في الاتصال: $e" };
    }
  }
}
