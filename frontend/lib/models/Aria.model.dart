import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

@HiveType(typeId: 4)
class Aria {
  @HiveField(0)
  String localId = uuid.v4();
  @HiveField(1)
  int Id;
  @HiveField(2)
  String Name;
  @HiveField(3)
  String Location;
  @HiveField(4)
  int CenterId;
  @HiveField(5)
  int SupervisorId;
  @HiveField(6)
  int MentorId;
  @HiveField(7)
  bool IsSynced;
  @HiveField(8)
  bool IsDeleted;
  @HiveField(9)
  DateTime CreatedDate;
  @HiveField(10)
  DateTime UpdatedDate;

  Aria({
    required this.localId,
    required this.Id,
    required this.Name,
    required this.Location,
    required this.CenterId,
    required this.SupervisorId,
    required this.MentorId,
    required this.IsSynced,
    required this.IsDeleted,
    required this.CreatedDate,
    required this.UpdatedDate,
  });

  //! fromJson
  factory Aria.fromJson(Map<String, dynamic> json) => Aria(
        localId: json['localId'] ?? uuid.v4(),
        Id: json["Id"] is int ? json["Id"] : int.tryParse(json["Id"]?.toString() ?? "0") ?? 0,
        Name: json["Name"]?.toString() ?? "",
        Location: json["Location"]?.toString() ?? "",
        CenterId: json["CenterId"] is int ? json["CenterId"] : int.tryParse(json["CenterId"]?.toString() ?? "0") ?? 0,
        SupervisorId: json["SupervisorId"] is int ? json["SupervisorId"] : int.tryParse(json["SupervisorId"]?.toString() ?? "0") ?? 0,
        MentorId: json["MentorId"] is int ? json["MentorId"] : int.tryParse(json["MentorId"]?.toString() ?? "0") ?? 0,
        IsSynced: json['IsSynced'] ?? false,
        IsDeleted: json['IsDeleted'] ?? false,
        CreatedDate: json['CreatedDate'] != null ? (json['CreatedDate'] is String ? DateTime.parse(json['CreatedDate']) : json['CreatedDate']) : DateTime.now(),
        UpdatedDate: json['UpdatedDate'] != null ? (json['UpdatedDate'] is String ? DateTime.parse(json['UpdatedDate']) : json['UpdatedDate']) : DateTime.now(),
      );

  //! toJson
  Map<String, dynamic> toJson() => {
        "localId": localId,
        "Id": Id,
        "Name": Name,
        "Location": Location,
        "CenterId": CenterId,
        "SupervisorId": SupervisorId,
        "MentorId": MentorId,
        "IsSynced": IsSynced,
        "IsDeleted": IsDeleted,
        "CreatedDate": CreatedDate.toIso8601String(),
        "UpdatedDate": UpdatedDate.toIso8601String(),
      };
}
