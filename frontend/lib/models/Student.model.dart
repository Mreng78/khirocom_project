import 'dart:core';

class Student {
  int Id; 
  String Name;
  String Gender;
  String Username;
  String Password;
  String status;
  DateTime? stopDate;
  String? stopReason;
  DateTime? DismissedDate;
  String? DismissedReason;
  int Age;
  String current_Memorization_Sorah;
  String current_Memorization_Aya;
  String current_Revision_Sorah;
  String current_Revision_Aya;
  String phoneNumber;
  String? ImageUrl;
  String FatherNumber;
  String Category;
  int HalakatId;

  Student({
    required this.Id,
    required this.Name,
    required this.Gender,
    required this.Username,
    required this.Password,
    required this.status,
    this.stopDate,
    this.stopReason,
    this.DismissedDate,
    this.DismissedReason,
    required this.Age,
    required this.current_Memorization_Sorah,
    required this.current_Memorization_Aya,
    required this.phoneNumber,
    this.ImageUrl,
    required this.FatherNumber,
    required this.Category,
    required this.HalakatId,
    required this.current_Revision_Sorah,
    required this.current_Revision_Aya,
  });

  //! from json
  factory Student.fromJson(Map<String, dynamic> json) => Student(
        Id: json['Id']??0,
        Name: json['Name']??'',
        Gender: json['Gender']??'',
        Username: json['Username']??'',
        Password: json['Password']??'',
        status: json['status']??'',
        stopDate: json['stopDate'] != null ? DateTime.parse(json['stopDate']) : null,
        stopReason: json['stopReason']??'',
        DismissedDate: json['DismissedDate'] != null ? DateTime.parse(json['DismissedDate']) : null,
        DismissedReason: json['DismissedReason']??'',
        Age: json['Age']??0,
        current_Memorization_Sorah: json['current_Memorization_Sorah']?.toString() ?? '',
        current_Memorization_Aya: json['current_Memorization_Aya']?.toString() ?? '',
        phoneNumber: json['phoneNumber']?.toString() ?? '',
        ImageUrl: json['ImageUrl']?.toString() ?? '',
        FatherNumber: json['FatherNumber']?.toString() ?? '',
        Category: json['Category']?.toString() ?? '',
        HalakatId: json['HalakatId'] ?? 0,
        current_Revision_Sorah: json['current_Revision_Sorah']?.toString() ?? '',
        current_Revision_Aya: json['current_Revision_Aya']?.toString() ?? '',
      );

  //! to json
  Map<String, dynamic> toJson() => {
        'Id': Id,
        'Name': Name,
        'Gender': Gender,
        'Username': Username,
        'Password': Password,
        'status': status,
        'stopDate': stopDate?.toIso8601String(),
        'stopReason': stopReason,
        'DismissedDate': DismissedDate?.toIso8601String(),
        'DismissedReason': DismissedReason,
        'Age': Age,
        'current_Memorization_Sorah': current_Memorization_Sorah,
        'current_Memorization_Aya': current_Memorization_Aya,
        'phoneNumber': phoneNumber,
        'ImageUrl': ImageUrl,
        'FatherNumber': FatherNumber,
        'Category': Category,
        'HalakatId': HalakatId,
        'current_Revision_Sorah': current_Revision_Sorah,
        'current_Revision_Aya': current_Revision_Aya,
      };
}
