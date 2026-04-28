import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

@HiveType(typeId: 1)
class StudentPlan {
  @HiveField(0)
  String localId = uuid.v4();
  @HiveField(1)
  int? Id;
  @HiveField(2)
  String Current_Memorization_Surah;
  @HiveField(3)
  int Current_Memorization_Ayah;
  @HiveField(4)
  double Daily_Memorization_Amount;
  @HiveField(5)
  String target_Memorization_Surah;
  @HiveField(6)
  int target_Memorization_Ayah;
  @HiveField(7)
  double Daily_Revision_Amount;
  @HiveField(8)
  String Current_Revision;
  @HiveField(9)
  String target_Revision;
  @HiveField(10)
  DateTime StartsAt;
  @HiveField(11)
  DateTime EndsAt;
  @HiveField(12)
  bool Memorization_ItsDone;
  @HiveField(13)
  bool Revision_ItsDone;
  @HiveField(14)
  String Month;
  @HiveField(15)
  String Year;
  @HiveField(16)
  bool Is_Current_Month_Plan;
  @HiveField(17)
  int StudentId;
  @HiveField(18)
  int Revision_Cycles;
  @HiveField(19)
  String status;
  @HiveField(20)
  bool IsSynced;
  @HiveField(21)
  bool IsDeleted;
  @HiveField(22)
  DateTime CreatedDate;
  @HiveField(23)
  DateTime UpdatedDate;

  StudentPlan({
    this.localId,
    this.Id,
    required this.Current_Memorization_Surah,
    required this.Current_Memorization_Ayah,
    required this.Daily_Memorization_Amount,
    required this.target_Memorization_Surah,
    required this.target_Memorization_Ayah,
    required this.Daily_Revision_Amount,
    required this.Current_Revision,
    required this.target_Revision,
    required this.StartsAt,
    required this.EndsAt,
    required this.Memorization_ItsDone,
    required this.Revision_ItsDone,
    required this.StudentId,
    required this.Month,
    required this.Year,
    required this.Is_Current_Month_Plan,
    this.Revision_Cycles = 0,
    this.status = "قيد التنفيذ",
    this.IsSynced = false,
    this.IsDeleted = false,
    required this.CreatedDate,
    required this.UpdatedDate,
  });

  //! from Json - Backend sends PascalCase
  factory StudentPlan.fromJson(Map<String, dynamic> json) => StudentPlan(
    localId: json["localId"] ?? uuid.v4(),
    Id: json["Id"],
    Current_Memorization_Surah: json["Current_Memorization_Surah"],
    Current_Memorization_Ayah: json["Current_Memorization_Ayah"],
    Daily_Memorization_Amount: (json["Daily_Memorization_Amount"] is num)
        ? (json["Daily_Memorization_Amount"] as num).toDouble()
        : double.tryParse(
                json["Daily_Memorization_Amount"]?.toString() ?? "0",
              ) ??
              0.0,
    target_Memorization_Surah: json["target_Memorization_Surah"],
    target_Memorization_Ayah: json["target_Memorization_Ayah"],
    Daily_Revision_Amount: (json["Daily_Revision_Amount"] is num)
        ? (json["Daily_Revision_Amount"] as num).toDouble()
        : double.tryParse(json["Daily_Revision_Amount"]?.toString() ?? "0") ??
              0.0,
    Current_Revision: json["Current_Revision"],
    target_Revision: json["target_Revision"],
    StartsAt: DateTime.parse(json["StartsAt"]),
    EndsAt: DateTime.parse(json["EndsAt"]),
    Memorization_ItsDone: json["Memorization_ItsDone"] ?? false,
    Revision_ItsDone: json["Revision_ItsDone"] ?? false,
    StudentId: json["StudentId"] ?? 0,
    Month: json["Month"] ?? "",
    Year: json["Year"] ?? "",
    Is_Current_Month_Plan: json["Is_Current_Month_Plan"] ?? false,
    Revision_Cycles: json["Revision_Cycles"] ?? 0,
    status: json["status"] ?? "قيد التنفيذ",
    IsSynced: json["IsSynced"] ?? false,
    IsDeleted: json["IsDeleted"] ?? false,
    CreatedDate: json["CreatedDate"] != null ? (json["CreatedDate"] is String ? DateTime.parse(json["CreatedDate"]) : json["CreatedDate"]) : DateTime.now(),
    UpdatedDate: json["UpdatedDate"] != null ? (json["UpdatedDate"] is String ? DateTime.parse(json["UpdatedDate"]) : json["UpdatedDate"]) : DateTime.now(),
  );

  //! to Json - Backend expects PascalCase
  Map<String, dynamic> toJson() => {
    "Id": Id,
    "Current_Memorization_Surah": Current_Memorization_Surah,
    "Current_Memorization_Ayah": Current_Memorization_Ayah,
    "Daily_Memorization_Amount": Daily_Memorization_Amount,
    "target_Memorization_Surah": target_Memorization_Surah,
    "target_Memorization_Ayah": target_Memorization_Ayah,
    "Daily_Revision_Amount": Daily_Revision_Amount,
    "Current_Revision": Current_Revision,
    "target_Revision": target_Revision,
    "StartsAt": StartsAt.toIso8601String(),
    "EndsAt": EndsAt.toIso8601String(),
    "Memorization_ItsDone": Memorization_ItsDone,
    "Revision_ItsDone": Revision_ItsDone,
    "StudentId": StudentId,
    "Month": Month,
    "Year": Year,
    "Is_Current_Month_Plan": Is_Current_Month_Plan,
    "Revision_Cycles": Revision_Cycles,
    "status": status,
    "IsSynced": IsSynced,
    "IsDeleted": IsDeleted,
    "CreatedDate": CreatedDate.toIso8601String(),
    "UpdatedDate": UpdatedDate.toIso8601String(),
  };
}
