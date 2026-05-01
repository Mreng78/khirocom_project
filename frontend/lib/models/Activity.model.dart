import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

@HiveType(typeId: 5)
class Activity {
  @HiveField(0)
  String localId = uuid.v4();
  @HiveField(1)
  int? Id;
  @HiveField(2)
  String Name;
  @HiveField(3)
  DateTime Date;
  @HiveField(4)
  String? Place;
  @HiveField(5)
  String? Description;
  @HiveField(6)
  String Kind;
  @HiveField(7)
  int HalaqahId;
  @HiveField(8)
  bool IsSynced;
  @HiveField(9)
  bool IsDeleted;
  @HiveField(10)
  DateTime CreatedDate;
  @HiveField(11)
  DateTime UpdatedDate;

  Activity({
    required this.localId,
    this.Id,
    required this.Name,
    required this.Date,
    this.Place,
    this.Description,
    required this.Kind,
    required this.HalaqahId,
    required this.IsSynced,
    required this.IsDeleted,
    required this.CreatedDate,
    required this.UpdatedDate,
  });

  //! fromJson method
  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
    localId: json['localId'] ?? uuid.v4(),
    Id: json["Id"] ?? 0,
    Name: json["Name"] ?? "",
    Date: DateTime.parse(json["Date"] ?? DateTime.now().toString()),
    Place: json["Place"] ?? "",
    Description: json["Description"] ?? "",
    Kind: json["Kind"] ?? "",
    HalaqahId: json["HalaqahId"] ?? 0,
    IsSynced: json['IsSynced'] ?? false,
    IsDeleted: json['IsDeleted'] ?? false,
    CreatedDate: json['CreatedDate'] ?? DateTime.now(),
    UpdatedDate: json['UpdatedDate'] ?? DateTime.now(),
  );

  //! toJson method
  Map<String, dynamic> toJson() => {
    "localId": localId,
    "Id": Id,
    "Name": Name,
    "Date": Date.toIso8601String(),
    "Place": Place,
    "Description": Description,
    "Kind": Kind,
    "HalaqahId": HalaqahId,
    'IsSynced': IsSynced,
    'IsDeleted': IsDeleted,
    'CreatedDate': CreatedDate,
    'UpdatedDate': UpdatedDate,
  };
}
