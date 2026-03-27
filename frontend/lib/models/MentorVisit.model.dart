class MentorVisit{
  int Id;
  String Date;
  String Month;
  int Year;
  String Recommendation;
  int HalakatId;
  int MentorId;
  String HalakatName;
  String MentorName;

  MentorVisit({
    required this.Id,
    required this.Date,
    required this.Month,
    required this.Year,
    required this.Recommendation,
    required this.HalakatId,
    required this.MentorId,
    required this.HalakatName,
    required this.MentorName,
  });

  //! from json
  factory MentorVisit.fromJson(Map<String, dynamic> json) => MentorVisit(
        Id: json["Id"],
        Date: json["Date"],
        Month: json["Month"],
        Year: json["Year"],
        Recommendation: json["Recommendation"],
        HalakatId: json["HalakatId"],
        MentorId: json["MentorId"],
        HalakatName: json["HalakatName"],
        MentorName: json["MentorName"],
      );
//! to json
      Map<String, dynamic> toJson() => {
        "Id": Id,
        "Date": Date,
        "Month": Month,
        "Year": Year,
        "Recommendation": Recommendation,
        "HalakatId": HalakatId,
        "MentorId": MentorId,
        "HalakatName": HalakatName,
        "MentorName": MentorName,
      };
}
