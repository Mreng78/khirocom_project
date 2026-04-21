class DailyProgress {
  int Id;
  String Attendance;
  String Memorization_Progress_Surah;
  int Memorization_Progress_Ayah;
  String Revision_Progress_Surah;
  int Revision_Progress_Ayah;
  String Memorization_Level;
  String Revision_Level;
  String? Notes;
  String month;
  String DayName;
  String Date;
  int year;
  int StudentId;

  DailyProgress({
    required this.Id,
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
    required this.StudentId,
  });

  //! from json
  factory DailyProgress.fromJson(Map<String, dynamic> json) => DailyProgress(
        Id: json["Id"] is int ? json["Id"] : int.tryParse(json["Id"]?.toString() ?? "0") ?? 0,
        Attendance: json["Attendance"]?.toString() ?? "",
        Memorization_Progress_Surah: json["Memorization_Progress_Surah"]?.toString() ?? "",
        Memorization_Progress_Ayah: json["Memorization_Progress_Ayah"] is int ? json["Memorization_Progress_Ayah"] : int.tryParse(json["Memorization_Progress_Ayah"]?.toString() ?? "0") ?? 0,
        Revision_Progress_Surah: json["Revision_Progress_Surah"]?.toString() ?? "",
        Revision_Progress_Ayah: json["Revision_Progress_Ayah"] is int ? json["Revision_Progress_Ayah"] : int.tryParse(json["Revision_Progress_Ayah"]?.toString() ?? "0") ?? 0,
        Memorization_Level: json["Memorization_Level"]?.toString() ?? "",
        Revision_Level: json["Revision_Level"]?.toString() ?? "",
        Notes: json["Notes"]?.toString() ?? "",
        month: json["month"]?.toString() ?? "",
        DayName: json["DayName"]?.toString() ?? "",
        Date: json["Date"]?.toString() ?? "",
        year: json["year"] is int ? json["year"] : int.tryParse(json["year"]?.toString() ?? "0") ?? 0,
        StudentId: json["StudentId"] is int ? json["StudentId"] : int.tryParse(json["StudentId"]?.toString() ?? "0") ?? 0,
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
        "StudentId": StudentId,
      };
}
