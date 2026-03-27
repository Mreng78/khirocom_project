class Aria {
  int Id;
  String Name;
  String Location;
  int CenterId;
  int SupervisorId;
  int MentorId;

  Aria({
    required this.Id,
    required this.Name,
    required this.Location,
    required this.CenterId,
    required this.SupervisorId,
    required this.MentorId,
  });

  //! fromJson
  factory Aria.fromJson(Map<String, dynamic> json) => Aria(
    Id: json["Id"],
    Name: json["Name"],
    Location: json["Location"],
    CenterId: json["CenterId"],
    SupervisorId: json["SupervisorId"],
    MentorId: json["MentorId"],
  );

  //! toJson
  Map<String, dynamic> toJson() => {
    "Id": Id,
    "Name": Name,
    "Location": Location,
    "CenterId": CenterId,
    "SupervisorId": SupervisorId,
    "MentorId": MentorId,
  };
}
