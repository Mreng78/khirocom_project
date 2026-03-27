class Activity {
  int Id;
  String Name;
  DateTime Date;
  String? Place;
  String? Description;
  String Kind;
  int HalaqahId;

  Activity({
    required this.Id,
    required this.Name,
    required this.Date,
    this.Place,
    this.Description,
    required this.Kind,
    required this.HalaqahId,
  });

  //! fromJson method
  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
    Id: json["Id"],
    Name: json["Name"],
    Date: DateTime.parse(json["Date"]),
    Place: json["Place"],
    Description: json["Description"],
    Kind: json["Kind"],
    HalaqahId: json["HalaqahId"],
  );

  //! toJson method
  Map<String, dynamic> toJson() => {
    "Id": Id,
    "Name": Name,
    "Date": Date.toIso8601String(),
    "Place": Place,
    "Description": Description,
    "Kind": Kind,
    "HalaqahId": HalaqahId,
  };
}
