import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

@HiveType(typeId: 3)
class Center {
  @HiveField(0)
  String localId = uuid.v4();
  @HiveField(1)
  int? Id;
  @HiveField(2)
  String Name;
  @HiveField(3)
  String Location;
  @HiveField(4)
  int ManagerId;
  @HiveField(5)
  bool IsSynced;
  @HiveField(6)
  bool IsDeleted;
  @HiveField(7)
  DateTime CreatedDate;
  @HiveField(8)
  DateTime UpdatedDate;

  Center({
    required this.localId,
    this.Id,
    required this.Name,
    required this.Location,
    required this.ManagerId,
    required this.IsSynced,
    required this.IsDeleted,
    required this.CreatedDate,
    required this.UpdatedDate,
  });

  //! fromJson
  factory Center.fromJson(Map<String, dynamic> json) => Center(
        localId: json['localId'] ?? uuid.v4(),
        Id: json["Id"] is int ? json["Id"] : int.tryParse(json["Id"]?.toString() ?? ""),
        Name: json["Name"]?.toString() ?? "",
        Location: json["Location"]?.toString() ?? "",
        ManagerId: json["ManagerId"] is int ? json["ManagerId"] : int.tryParse(json["ManagerId"]?.toString() ?? "0") ?? 0,
        IsSynced: json['IsSynced'] ?? false,
        IsDeleted: json['IsDeleted'] ?? false,
        CreatedDate: json['CreatedDate'] != null ? (json['CreatedDate'] is String ? DateTime.parse(json['CreatedDate']) : json['CreatedDate']) : DateTime.now(),
        UpdatedDate: json['UpdatedDate'] != null ? (json['UpdatedDate'] is String ? DateTime.parse(json['UpdatedDate']) : json['UpdatedDate']) : DateTime.now(),
      );

  //! to Json
  Map<String, dynamic> toJson() => {
        'localId': localId,
        "Id": Id,
        "Name": Name,
        "Location": Location,
        "ManagerId": ManagerId,
        'IsSynced': IsSynced,
        'IsDeleted': IsDeleted,
        'CreatedDate': CreatedDate.toIso8601String(),
        'UpdatedDate': UpdatedDate.toIso8601String(),
      };
}
