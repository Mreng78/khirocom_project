import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

@HiveType(typeId: 6)
class DailyProgress {
  @HiveField(0)
  String localId = uuid.v4();
  @HiveField(1)
  int? Id;
  @HiveField(2)
  String Attendance;
  @HiveField(3)
  String Memorization_Progress_Surah;
  @HiveField(4)
  int Memorization_Progress_Ayah;
  @HiveField(5)
  String Revision_Progress_Surah;
  @HiveField(6)
  int Revision_Progress_Ayah;
  @HiveField(7)
  String Memorization_Level;
  @HiveField(8)
  String Revision_Level;
  @HiveField(9)
  String? Notes;
  @HiveField(10)
  String month;
  @HiveField(11)
  String DayName;
  @HiveField(12)
  String Date;
  @HiveField(13)
  int year;
  @HiveField(14)
  String Month_year;
  @HiveField(15)
  int StudentId;
  @HiveField(16)
  bool IsSynced;
  @HiveField(17)
  bool IsDeleted;
  @HiveField(18)
  DateTime CreatedDate;
  @HiveField(19)
  DateTime UpdatedDate;

  DailyProgress({
    this.Id,
    required this.Attendance,
    required this.Memorization_Progress_Surah,
    required this.Memorization_Progress_Ayah,
    required this.Revision_Progress_Surah,
    required this.Revision_Progress_Ayah,
    required this.Memorization_Level,
    required this.Revision_Level,
    this.Notes,
    required this.month,
    required this.DayName,
    required this.Date,
    required this.year,
    required this.Month_year,
    required this.StudentId,
    this.IsSynced = false,
    this.IsDeleted = false,
    required this.CreatedDate,
    required this.UpdatedDate,
  });

  //! from json
  factory DailyProgress.fromJson(Map<String, dynamic> json) => DailyProgress(
    Id: json["Id"] is int
        ? json["Id"]
        : int.tryParse(json["Id"]?.toString() ?? "0") ?? 0,
    Attendance: json["Attendance"]?.toString() ?? "",
    Memorization_Progress_Surah:
        json["Memorization_Progress_Surah"]?.toString() ?? "",
    Memorization_Progress_Ayah: json["Memorization_Progress_Ayah"] is int
        ? json["Memorization_Progress_Ayah"]
        : int.tryParse(json["Memorization_Progress_Ayah"]?.toString() ?? "0") ??
              0,
    Revision_Progress_Surah: json["Revision_Progress_Surah"]?.toString() ?? "",
    Revision_Progress_Ayah: json["Revision_Progress_Ayah"] is int
        ? json["Revision_Progress_Ayah"]
        : int.tryParse(json["Revision_Progress_Ayah"]?.toString() ?? "0") ?? 0,
    Memorization_Level: json["Memorization_Level"]?.toString() ?? "",
    Revision_Level: json["Revision_Level"]?.toString() ?? "",
    Notes: json["Notes"]?.toString() ?? "",
    month: json["month"]?.toString() ?? "",
    DayName: json["DayName"]?.toString() ?? "",
    Date: json["Date"]?.toString() ?? "",
    year: json["year"] is int
        ? json["year"]
        : int.tryParse(json["year"]?.toString() ?? "0") ?? 0,
    Month_year: json["Month_year"]?.toString() ?? "",
    StudentId: json["StudentId"] is int
        ? json["StudentId"]
        : int.tryParse(json["StudentId"]?.toString() ?? "0") ?? 0,
    IsSynced: json["IsSynced"] ?? false,
    IsDeleted: json["IsDeleted"] ?? false,
    CreatedDate: json["CreatedDate"] != null ? DateTime.parse(json["CreatedDate"]) : DateTime.now(),
    UpdatedDate: json["UpdatedDate"] != null ? DateTime.parse(json["UpdatedDate"]) : DateTime.now(),
  );

  //! to json
  Map<String, dynamic> toJson() => {
    "Id": Id,
    "Attendance": Attendance,
    "Memorization_Progress_Surah": Memorization_Progress_Surah,
    "Memorization_Progress_Ayah": Memorization_Progress_Ayah,
    "Revision_Progress_Surah": Revision_Progress_Surah,
    "Revision_Progress_Ayah": Revision_Progress_Ayah,
    "Memorization_Level": Memorization_Level,
    "Revision_Level": Revision_Level,
    "Notes": Notes,
    "month": month,
    "DayName": DayName,
    "Date": Date,
    "year": year,
    "Month_year": Month_year,
    "StudentId": StudentId,
    "IsSynced": IsSynced,
    "IsDeleted": IsDeleted,
    "CreatedDate": CreatedDate.toIso8601String(),
    "UpdatedDate": UpdatedDate.toIso8601String(),
  };
}
