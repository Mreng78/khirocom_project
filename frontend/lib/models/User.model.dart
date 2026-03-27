class User {
  int Id;
  String Name;
  String Username;
  String Password;
  String PhoneNumber;
  String? AvatarUrl;
  String Role;
  String Gender;
  int Age;
  String EducationLevel;
  double Salary;
  String Address;

  User({
    required this.Id,
    required this.Name,
    required this.Username,
    required this.Password,
    required this.PhoneNumber,
    this.AvatarUrl,
    required this.Role,
    required this.Gender,
    required this.Age,
    required this.EducationLevel,
    required this.Salary,
    required this.Address,
  });

  //! from json to object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      Id: json['Id'],
      Name: json['Name'],
      Username: json['Username'],
      Password: json['Password'],
      PhoneNumber: json['PhoneNumber'],
      AvatarUrl: json['AvatarUrl'],
      Role: json['Role'],
      Gender: json['Gender'],
      Age: json['Age'],
      EducationLevel: json['EducationLevel'],
      Salary: json['Salary']?.toDouble() ?? 0.0,
      Address: json['Address'],
    );
  }
  
  //! from object to json
  Map<String, dynamic> toJson() {
    return {
      'Id': Id,
      'Name': Name,
      'Username': Username,
      'Password': Password,
      'PhoneNumber': PhoneNumber,
      'AvatarUrl': AvatarUrl,
      'Role': Role,
      'Gender': Gender,
      'Age': Age,
      'EducationLevel': EducationLevel,
      'Salary': Salary,
      'Address': Address,
    };
  }
}