class Graduate {
  int Id;
  DateTime GraduationDate;
  int StudentId;

  Graduate({
    required this.Id,
    required this.GraduationDate,
    required this.StudentId,
  });

  //! fromJson
  factory Graduate.fromJson(Map<String, dynamic> json) => Graduate(
        Id: json["Id"],
        GraduationDate: DateTime.parse(json["GraduationDate"]),
        StudentId: json["StudentId"],
      );

  //! toJson
  Map<String, dynamic> toJson() => {
        "Id": Id,
        "GraduationDate": GraduationDate.toIso8601String(),
        "StudentId": StudentId,
      };
}
