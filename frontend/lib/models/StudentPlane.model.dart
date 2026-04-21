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
  bool ItsDone;
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
    required this.ItsDone,
    required this.StudentId,
  });

  //! from Json - Backend sends PascalCase
  factory StudentPlan.fromJson(Map<String, dynamic> json) => StudentPlan(
    Id: json["Id"],
    Current_Memorization_Surah: json["Current_Memorization_Surah"],
    Current_Memorization_Ayah: json["Current_Memorization_Ayah"],
    Daily_Memorization_Amount: json["Daily_Memorization_Amount"]?.toDouble() ?? 0.0,
    target_Memorization_Surah: json["target_Memorization_Surah"],
    target_Memorization_Ayah: json["target_Memorization_Ayah"],
    Daily_Revision_Amount: json["Daily_Revision_Amount"]?.toDouble() ?? 0.0,
    Current_Revision: json["Current_Revision"],
    target_Revision: json["target_Revision"],
    StartsAt: DateTime.parse(json["StartsAt"]),
    EndsAt: DateTime.parse(json["EndsAt"]),
    ItsDone: json["ItsDone"] ?? false,
    StudentId: json["StudentId"],
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
    "ItsDone": ItsDone,
    "StudentId": StudentId,
  };
}
