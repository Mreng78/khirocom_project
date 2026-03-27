class Center {
  int Id;
  String Name;
  String Location;
  int ManagerId;

  Center({
    required this.Id,
    required this.Name,
    required this.Location,
    required this.ManagerId,
  });

  //! fromJson
  factory Center.fromJson(Map<String, dynamic> json) => Center(
    Id: json["Id"],
    Name: json["Name"],
    Location: json["Location"],
    ManagerId: json["ManagerId"],
  );

  //! to Json
  Map<String, dynamic> toJson() => {
    "Id": Id,
    "Name": Name,
    "Location": Location,
    "ManagerId": ManagerId,
  };
}
