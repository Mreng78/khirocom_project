import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

@HiveType(typeId: 8)
class Halakat {
  @HiveField(0)
  String localId = uuid.v4();
  @HiveField(1)
  int Id;
  @HiveField(2)
  String Name;
  @HiveField(3)
  String studentsGender;
  @HiveField(4)
  String type;
  @HiveField(5)
  int TeacherId;
  @HiveField(6)
  int AriaId;
  @HiveField(7)
  String teacherName;
  @HiveField(8)
  String ariaName;
  @HiveField(9)
  bool IsSynced;
  @HiveField(10)
  bool IsDeleted;
  @HiveField(11)
  DateTime CreatedDate;
  @HiveField(12)
  DateTime UpdatedDate;

  Halakat({
    required this.localId,
    required this.Id,
    required this.Name,
    required this.studentsGender,
    required this.type,
    required this.TeacherId,
    required this.AriaId,
    required this.teacherName,
    required this.ariaName,
    required this.IsSynced,
    required this.IsDeleted,
    required this.CreatedDate,
    required this.UpdatedDate,
  });

  //! from Json
  factory Halakat.fromJson(Map<String, dynamic> json) => Halakat(
        localId: json["localId"] ?? uuid.v4(),
        Id: json["Id"] is int ? json["Id"] : int.tryParse(json["Id"]?.toString() ?? "0") ?? 0,
        Name: json["Name"]?.toString() ?? "",
        studentsGender: json["studentsGender"]?.toString() ?? "",
        type: json["type"]?.toString() ?? "",
        TeacherId: json["TeacherId"] is int ? json["TeacherId"] : int.tryParse(json["TeacherId"]?.toString() ?? "0") ?? 0,
        AriaId: json["AriaId"] is int ? json["AriaId"] : int.tryParse(json["AriaId"]?.toString() ?? "0") ?? 0,
        teacherName: json["teacherName"]?.toString() ?? "",
        ariaName: json["ariaName"]?.toString() ?? "",
        IsSynced: json["IsSynced"] ?? false,
        IsDeleted: json["IsDeleted"] ?? false,
        CreatedDate: json['CreatedDate'] != null ? (json['CreatedDate'] is String ? DateTime.parse(json['CreatedDate']) : json['CreatedDate']) : DateTime.now(),
        UpdatedDate: json['UpdatedDate'] != null ? (json['UpdatedDate'] is String ? DateTime.parse(json['UpdatedDate']) : json['UpdatedDate']) : DateTime.now(),
      );

  //! to Json
  Map<String, dynamic> toJson() => {
        "localId": localId,
        "Id": Id,
        "Name": Name,
        "studentsGender": studentsGender,
        "type": type,
        "TeacherId": TeacherId,
        "AriaId": AriaId,
        "teacherName": teacherName,
        "ariaName": ariaName,
        "IsSynced": IsSynced,
        "IsDeleted": IsDeleted,
        "CreatedDate": CreatedDate.toIso8601String(),
        "UpdatedDate": UpdatedDate.toIso8601String(),
      };
}
