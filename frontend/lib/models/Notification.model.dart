class Notification {
  int Id;
  String Title;
  String Description;
  DateTime Date;
  DateTime Time;
  String Type;
  String forWho;
  bool IsRead;
  DateTime? ReadAt;
  int? UserId;
  int? StudentId;

  Notification({
    required this.Id,
    required this.Title,
    required this.Description,
    required this.Date,
    required this.Time,
    required this.Type,
    required this.forWho,
    required this.IsRead,
    this.ReadAt,
    this.UserId,
    this.StudentId,
  });

  //! Convert JSON to Notification

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    Id: json["Id"],
    Title: json["Title"],
    Description: json["Description"],
    Date: DateTime.parse(json["Date"]),
    Time: DateTime.parse(json["Time"]),
    Type: json["Type"],
    forWho: json["forWho"],
    IsRead: json["IsRead"],
    ReadAt: json["ReadAt"] != null ? DateTime.parse(json["ReadAt"]) : null,
    UserId: json["UserId"],
    StudentId: json["StudentId"],
  );

  //! Convert Notification to JSON
  Map<String, dynamic> toJson() => {
    "Id": Id,
    "Title": Title,
    "Description": Description,
    "Date": Date.toIso8601String(),
    "Time": Time.toIso8601String(),
    "Type": Type,
    "forWho": forWho,
    "IsRead": IsRead,
    "ReadAt": ReadAt?.toIso8601String(),
    "UserId": UserId,
    "StudentId": StudentId,
  };
}
