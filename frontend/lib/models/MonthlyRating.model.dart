class MonthlyRating {
  int Id;
  double Memoisation_degree;
  double Telawah_degree;
  double Tajweed_degree;
  double Motoon_degree;
  double Total_degree;
  double Average;
  String? Notes;
  int StudentId;
  int MentorVisetId;

  MonthlyRating({
    required this.Id,
    required this.Memoisation_degree,
    required this.Telawah_degree,
    required this.Tajweed_degree,
    required this.Motoon_degree,
    required this.Total_degree,
    required this.Average,
    this.Notes,
    required this.StudentId,
    required this.MentorVisetId,
  });

  //! Convert JSON to MonthlyRating
  factory MonthlyRating.fromJson(Map<String, dynamic> json) => MonthlyRating(
        Id: json["Id"],
        Memoisation_degree: json["Memoisation_degree"]?.toDouble() ?? 0.0,
        Telawah_degree: json["Telawah_degree"]?.toDouble() ?? 0.0,
        Tajweed_degree: json["Tajweed_degree"]?.toDouble() ?? 0.0,
        Motoon_degree: json["Motoon_degree"]?.toDouble() ?? 0.0,
        Total_degree: json["Total_degree"]?.toDouble() ?? 0.0,
        Average: json["Average"]?.toDouble() ?? 0.0,
        Notes: json["Notes"],
        StudentId: json["StudentId"],
        MentorVisetId: json["MentorVisetId"],
      );

  //! Convert MonthlyRating to JSON
  Map<String, dynamic> toJson() => {
        "Id": Id,
        "Memoisation_degree": Memoisation_degree,
        "Telawah_degree": Telawah_degree,
        "Tajweed_degree": Tajweed_degree,
        "Motoon_degree": Motoon_degree,
        "Total_degree": Total_degree,
        "Average": Average,
        "Notes": Notes,
        "StudentId": StudentId,
        "MentorVisetId": MentorVisetId,
      };
}

