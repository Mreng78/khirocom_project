class StudentPlan {
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
  bool Memorization_ItsDone;
  bool Revision_ItsDone;
  String Month;
  String Year;
  bool Is_Current_Month_Plan;
  int StudentId;

  StudentPlan({
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
  });

  //! from Json - Backend sends PascalCase
  factory StudentPlan.fromJson(Map<String, dynamic> json) => StudentPlan(
    Id: json["Id"],
    Current_Memorization_Surah: json["Current_Memorization_Surah"],
    Current_Memorization_Ayah: json["Current_Memorization_Ayah"],
    Daily_Memorization_Amount: (json["Daily_Memorization_Amount"] is num) 
        ? (json["Daily_Memorization_Amount"] as num).toDouble() 
        : double.tryParse(json["Daily_Memorization_Amount"]?.toString() ?? "0") ?? 0.0,
    target_Memorization_Surah: json["target_Memorization_Surah"],
    target_Memorization_Ayah: json["target_Memorization_Ayah"],
    Daily_Revision_Amount: (json["Daily_Revision_Amount"] is num) 
        ? (json["Daily_Revision_Amount"] as num).toDouble() 
        : double.tryParse(json["Daily_Revision_Amount"]?.toString() ?? "0") ?? 0.0,
    Current_Revision: json["Current_Revision"],
    target_Revision: json["target_Revision"],
    StartsAt: DateTime.parse(json["StartsAt"]),
    EndsAt: DateTime.parse(json["EndsAt"]),
    Memorization_ItsDone: json["Memorization_ItsDone"] ?? false,
    Revision_ItsDone: json["Revision_ItsDone"] ?? false,
    StudentId: json["StudentId"] ??0,
    Month: json["Month"] ?? "",
    Year: json["Year"] ?? "",
    Is_Current_Month_Plan: json["Is_Current_Month_Plan"] ?? false,
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
  };
}
