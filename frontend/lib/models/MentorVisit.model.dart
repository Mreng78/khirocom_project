import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';

var uuid = Uuid();

@HiveType(typeId: 9)
class MentorVisit {
  @HiveField(0)
  String localId = uuid.v4();
  @HiveField(1)
  int? Id;
  @HiveField(2)
  String Date;
  @HiveField(3)
  String Month;
  @HiveField(4)
  int Year;
  @HiveField(5)
  String Recommendation;
  @HiveField(6)
  int HalakatId;
  @HiveField(7)
  int MentorId;
  @HiveField(8)
  String HalakatName;
  @HiveField(9)
  String MentorName;
  @HiveField(10)
  bool IsSynced;
  @HiveField(11)
  bool IsDeleted;
  @HiveField(12)
  DateTime CreatedDate;
  @HiveField(13)
  DateTime UpdatedDate;

  MentorVisit({
    required this.localId,
    this.Id,
    required this.Date,
    required this.Month,
    required this.Year,
    required this.Recommendation,
    required this.HalakatId,
    required this.MentorId,
    required this.HalakatName,
    required this.MentorName,
    this.IsSynced = false,
    this.IsDeleted = false,
    required this.CreatedDate,
    required this.UpdatedDate,
  });

  //! from json
  factory MentorVisit.fromJson(Map<String, dynamic> json) => MentorVisit(
    localId: json["localId"] ?? uuid.v4(),
    Id: json["Id"] is int
        ? json["Id"]
        : int.tryParse(json["Id"]?.toString() ?? ""),
    Date: json["Date"]?.toString() ?? "",
    Month: json["Month"]?.toString() ?? "",
    Year: json["Year"] is int
        ? json["Year"]
        : int.tryParse(json["Year"]?.toString() ?? "0") ?? 0,
    Recommendation: json["Recommendation"]?.toString() ?? "",
    HalakatId: json["HalakatId"] is int
        ? json["HalakatId"]
        : int.tryParse(json["HalakatId"]?.toString() ?? "0") ?? 0,
    MentorId: json["MentorId"] is int
        ? json["MentorId"]
        : int.tryParse(json["MentorId"]?.toString() ?? "0") ?? 0,
    HalakatName: json["HalakatName"]?.toString() ?? "",
    MentorName: json["MentorName"]?.toString() ?? "",
    IsSynced: json["IsSynced"] ?? false,
    IsDeleted: json["IsDeleted"] ?? false,
    CreatedDate: json["CreatedDate"] != null
        ? DateTime.parse(json["CreatedDate"])
        : DateTime.now(),
    UpdatedDate: json["UpdatedDate"] != null
        ? DateTime.parse(json["UpdatedDate"])
        : DateTime.now(),
  );

  //! to json
  Map<String, dynamic> toJson() => {
    "localId": localId,
    "Id": Id,
    "Date": Date,
    "Month": Month,
    "Year": Year,
    "Recommendation": Recommendation,
    "HalakatId": HalakatId,
    "MentorId": MentorId,
    "HalakatName": HalakatName,
    "MentorName": MentorName,
    "IsSynced": IsSynced,
    "IsDeleted": IsDeleted,
    "CreatedDate": CreatedDate.toIso8601String(),
    "UpdatedDate": UpdatedDate.toIso8601String(),
  };
}
