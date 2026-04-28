import 'package:uuid/uuid.dart';

var uuid = Uuid();

class StudentPlan {
  String localId;
  int? Id;
  String Current_Memorization_Surah;
  int Current_Memorization_Ayah;
  double Daily_Memorization_Amount;
  String target_Memorization_Surah;
  int target_Memorization_Ayah;
  double Daily_Revision_Amount;
  String Current_Revision;
  String target_Revision;
  DateTime StartsAt;
  DateTime EndsAt;
  String Month;
  String Year;
  bool Is_Current_Month_Plan;
  bool Memorization_ItsDone;
  bool Revision_ItsDone;
  int StudentId;
  int Revision_Cycles;
  String status;
  bool IsSynced;
  bool IsDeleted;
  DateTime CreatedDate;
  DateTime UpdatedDate;

  StudentPlan({
    String? localId,
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
    required this.Month,
    required this.Year,
    this.Is_Current_Month_Plan = false,
    this.Memorization_ItsDone = false,
    this.Revision_ItsDone = false,
    required this.StudentId,
    this.Revision_Cycles = 0,
    this.status = "قيد التنفيذ",
    this.IsSynced = false,
    this.IsDeleted = false,
    required this.CreatedDate,
    required this.UpdatedDate,
  }) : this.localId = localId ?? uuid.v4();

  factory StudentPlan.fromJson(Map<String, dynamic> json) => StudentPlan(
        localId: json["localId"] ?? uuid.v4(),
        Id: json["Id"] is int ? json["Id"] : int.tryParse(json["Id"]?.toString() ?? ""),
        Current_Memorization_Surah: json["Current_Memorization_Surah"]?.toString() ?? "",
        Current_Memorization_Ayah: json["Current_Memorization_Ayah"] is int
            ? json["Current_Memorization_Ayah"]
            : int.tryParse(json["Current_Memorization_Ayah"]?.toString() ?? "0") ?? 0,
        Daily_Memorization_Amount: json["Daily_Memorization_Amount"] is num
            ? (json["Daily_Memorization_Amount"] as num).toDouble()
            : double.tryParse(json["Daily_Memorization_Amount"]?.toString() ?? "0.0") ?? 0.0,
        target_Memorization_Surah: json["target_Memorization_Surah"]?.toString() ?? "",
        target_Memorization_Ayah: json["target_Memorization_Ayah"] is int
            ? json["target_Memorization_Ayah"]
            : int.tryParse(json["target_Memorization_Ayah"]?.toString() ?? "0") ?? 0,
        Daily_Revision_Amount: json["Daily_Revision_Amount"] is num
            ? (json["Daily_Revision_Amount"] as num).toDouble()
            : double.tryParse(json["Daily_Revision_Amount"]?.toString() ?? "0.0") ?? 0.0,
        Current_Revision: json["Current_Revision"]?.toString() ?? "",
        target_Revision: json["target_Revision"]?.toString() ?? "",
        StartsAt: json["StartsAt"] != null ? DateTime.parse(json["StartsAt"]) : DateTime.now(),
        EndsAt: json["EndsAt"] != null ? DateTime.parse(json["EndsAt"]) : DateTime.now(),
        Month: json["Month"]?.toString() ?? "",
        Year: json["Year"]?.toString() ?? "",
        Is_Current_Month_Plan: json["Is_Current_Month_Plan"] ?? false,
        Memorization_ItsDone: json["Memorization_ItsDone"] ?? false,
        Revision_ItsDone: json["Revision_ItsDone"] ?? false,
        StudentId: json["StudentId"] is int
            ? json["StudentId"]
            : int.tryParse(json["StudentId"]?.toString() ?? "0") ?? 0,
        Revision_Cycles: json["Revision_Cycles"] is int
            ? json["Revision_Cycles"]
            : int.tryParse(json["Revision_Cycles"]?.toString() ?? "0") ?? 0,
        status: json["status"]?.toString() ?? "قيد التنفيذ",
        IsSynced: json["IsSynced"] ?? false,
        IsDeleted: json["IsDeleted"] ?? false,
        CreatedDate: json["CreatedDate"] != null ? DateTime.parse(json["CreatedDate"]) : DateTime.now(),
        UpdatedDate: json["UpdatedDate"] != null ? DateTime.parse(json["UpdatedDate"]) : DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        "localId": localId,
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
        "Month": Month,
        "Year": Year,
        "Is_Current_Month_Plan": Is_Current_Month_Plan,
        "Memorization_ItsDone": Memorization_ItsDone,
        "Revision_ItsDone": Revision_ItsDone,
        "StudentId": StudentId,
        "Revision_Cycles": Revision_Cycles,
        "status": status,
        "IsSynced": IsSynced,
        "IsDeleted": IsDeleted,
        "CreatedDate": CreatedDate.toIso8601String(),
        "UpdatedDate": UpdatedDate.toIso8601String(),
      };
}