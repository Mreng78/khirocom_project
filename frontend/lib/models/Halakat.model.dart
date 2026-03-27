class Halakat {
  int Id;
  String Name;
  String studentsGender;
  String type;
  int TeacherId;
  int AriaId;
  String teacherName;
  String ariaName;

  Halakat({
    required this.Id,
    required this.Name,
    required this.studentsGender,
    required this.type,
    required this.TeacherId,
    required this.AriaId,
    required this.teacherName,
    required this.ariaName,
  });

  //! from Json
  factory Halakat.fromJson(Map<String, dynamic> json) => Halakat(
    Id: json["Id"],
    Name: json["Name"],
    studentsGender: json["studentsGender"],
    type: json["type"],
    TeacherId: json["TeacherId"],
    AriaId: json["AriaId"],
    teacherName: json["teacherName"],
    ariaName: json["ariaName"],
  );

  //! to Json
  Map<String, dynamic> toJson() => {
    "Id": Id,
    "Name": Name,
    "studentsGender": studentsGender,
    "type": type,
    "TeacherId": TeacherId,
    "AriaId": AriaId,
    "teacherName": teacherName,
    "ariaName": ariaName,
  };
}
