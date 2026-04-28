import 'dart:core';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

@HiveType(typeId: 2)
class Student {
  @HiveField(0)
  String localId = uuid.v4();
  @HiveField(1)
  int Id;
  @HiveField(2)
  String Name;
  @HiveField(3)
  String Gender;
  @HiveField(4)
  String Username;
  @HiveField(5)
  String Password;
  @HiveField(6)
  String status;
  @HiveField(7)
  DateTime? stopDate;
  @HiveField(8)
  String? stopReason;
  @HiveField(9)
  DateTime? DismissedDate;
  @HiveField(10)
  String? DismissedReason;
  @HiveField(11)
  int Age;
  @HiveField(12)
  String current_Memorization_Sorah;
  @HiveField(13)
  String current_Memorization_Aya;
  @HiveField(14)
  String current_Revision_Sorah;
  @HiveField(15)
  String current_Revision_Aya;
  @HiveField(16)
  String phoneNumber;
  @HiveField(17)
  String? ImageUrl;
  @HiveField(18)
  String FatherNumber;
  @HiveField(19)
  String Category;
  @HiveField(20)
  int HalakatId;
  @HiveField(21)
  int total_Revision_Cycles;
  @HiveField(22)
  bool IsSynced;
  @HiveField(23)
  bool IsDeleted;
  @HiveField(24)
  DateTime CreatedDate;
  @HiveField(25)
  DateTime UpdatedDate;

  Student({
    required this.localId,
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
    this.total_Revision_Cycles = 0,
    required this.IsSynced,
    required this.IsDeleted,
    required this.CreatedDate,
    required this.UpdatedDate,
  });

  //! from json
  factory Student.fromJson(Map<String, dynamic> json) => Student(
    localId: json['localId'] ?? uuid.v4(),
    Id: json['Id'] ?? 0,
    Name: json['Name'] ?? '',
    Gender: json['Gender'] ?? '',
    Username: json['Username'] ?? '',
    Password: json['Password'] ?? '',
    status: json['status'] ?? '',
    stopDate: json['stopDate'] != null
        ? DateTime.parse(json['stopDate'])
        : null,
    stopReason: json['stopReason'] ?? '',
    DismissedDate: json['DismissedDate'] != null
        ? DateTime.parse(json['DismissedDate'])
        : null,
    DismissedReason: json['DismissedReason'] ?? '',
    Age: json['Age'] ?? 0,
    current_Memorization_Sorah:
        json['current_Memorization_Sorah']?.toString() ?? '',
    current_Memorization_Aya:
        json['current_Memorization_Aya']?.toString() ?? '',
    phoneNumber: json['phoneNumber']?.toString() ?? '',
    ImageUrl: json['ImageUrl']?.toString() ?? '',
    FatherNumber: json['FatherNumber']?.toString() ?? '',
    Category: json['Category']?.toString() ?? '',
    HalakatId: json['HalakatId'] ?? 0,
    current_Revision_Sorah: json['current_Revision_Sorah']?.toString() ?? '',
    current_Revision_Aya: json['current_Revision_Aya']?.toString() ?? '',
    total_Revision_Cycles: json['total_Revision_Cycles'] ?? 0,
    IsSynced: json['IsSynced'] ?? false,
    IsDeleted: json['IsDeleted'] ?? false,
    CreatedDate: json['CreatedDate'] ?? DateTime.now(),
    UpdatedDate: json['UpdatedDate'] ?? DateTime.now(),
  );

  //! to json
  Map<String, dynamic> toJson() => {
    'localId': localId,
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
    'total_Revision_Cycles': total_Revision_Cycles,
    'IsSynced': IsSynced,
    'IsDeleted': IsDeleted,
    'CreatedDate': CreatedDate,
    'UpdatedDate': UpdatedDate,
  };
}
