class DailyProgress {
  int Id;
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
        Id: json["Id"],
        Memorization_Progress_Surah: json["Memorization_Progress_Surah"],
        Memorization_Progress_Ayah: json["Memorization_Progress_Ayah"],
        Revision_Progress_Surah: json["Revision_Progress_Surah"],
        Revision_Progress_Ayah: json["Revision_Progress_Ayah"],
        Memorization_Level: json["Memorization_Level"],
        Revision_Level: json["Revision_Level"],
        Notes: json["Notes"],
        month: json["month"],
        DayName: json["DayName"],
        Date: json["Date"],
        year: json["year"],
        StudentId: json["StudentId"],
      );

  //! to json
  Map<String, dynamic> toJson() => {
        "Id": Id,
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
