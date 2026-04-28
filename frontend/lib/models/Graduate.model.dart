import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

@HiveType(typeId: 7)
class Graduate {
  @HiveField(0)
  String localId = uuid.v4();
  @HiveField(1)
  int? Id;
  @HiveField(2)
  DateTime GraduationDate;
  @HiveField(3)
  int StudentId;
  @HiveField(4)
  bool IsSynced;
  @HiveField(5)
  bool IsDeleted;
  @HiveField(6)
  DateTime CreatedDate;
  @HiveField(7)
  DateTime UpdatedDate;

  Graduate({
    required this.localId,
    this.Id,
    required this.GraduationDate,
    required this.StudentId,
    required this.IsSynced,
    required this.IsDeleted,
    required this.CreatedDate,
    required this.UpdatedDate,
  });

  //! fromJson
  factory Graduate.fromJson(Map<String, dynamic> json) => Graduate(
        localId: json['localId'] ?? uuid.v4(),
        Id: json["Id"] is int ? json["Id"] : int.tryParse(json["Id"]?.toString() ?? ""),
        GraduationDate: json["GraduationDate"] != null ? (json["GraduationDate"] is String ? DateTime.parse(json["GraduationDate"]) : json["GraduationDate"]) : DateTime.now(),
        StudentId: json["StudentId"] is int ? json["StudentId"] : int.tryParse(json["StudentId"]?.toString() ?? "0") ?? 0,
        IsSynced: json['IsSynced'] ?? false,
        IsDeleted: json['IsDeleted'] ?? false,
        CreatedDate: json['CreatedDate'] != null ? (json['CreatedDate'] is String ? DateTime.parse(json['CreatedDate']) : json['CreatedDate']) : DateTime.now(),
        UpdatedDate: json['UpdatedDate'] != null ? (json['UpdatedDate'] is String ? DateTime.parse(json['UpdatedDate']) : json['UpdatedDate']) : DateTime.now(),
      );

  //! toJson
  Map<String, dynamic> toJson() => {
        "localId": localId,
        "Id": Id,
        "GraduationDate": GraduationDate.toIso8601String(),
        "StudentId": StudentId,
        "IsSynced": IsSynced,
        "IsDeleted": IsDeleted,
        "CreatedDate": CreatedDate.toIso8601String(),
        "UpdatedDate": UpdatedDate.toIso8601String(),
      };
}
