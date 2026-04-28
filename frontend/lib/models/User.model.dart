import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  String localId = uuid.v4();
  @HiveField(1)
  int Id;
  @HiveField(2)
  String Name;
  @HiveField(3)
  String Username;
  @HiveField(4)
  String Password;
  @HiveField(5)
  String PhoneNumber;
  @HiveField(6)
  String? ImageUrl;
  @HiveField(7)
  String Role;
  @HiveField(8)
  String Gender;
  @HiveField(9)
  int? Age;
  @HiveField(10)
  String EducationLevel;
  @HiveField(11)
  double Salary;
  @HiveField(11)
  String Address;

  @HiveField(12)
  bool IsSynced;

  @HiveField(13)
  bool isdeleted;

  @HiveField(14)
  DateTime CreatedDate;

  @HiveField(15)
  DateTime UpdatedDate;

  User({
    required this.localId,
    required this.Id,
    required this.Name,
    required this.Username,
    required this.Password,
    required this.PhoneNumber,
    this.ImageUrl,
    required this.Role,
    required this.Gender,
    required this.Age,
    required this.EducationLevel,
    required this.Salary,
    required this.Address,
    required this.IsSynced,
    required this.isdeleted,
    required this.CreatedDate,
    required this.UpdatedDate,
  });

  //! from json to object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      localId: json['localId'] ?? 0,
      Id: json['Id'] ?? 0,
      Name: json['Name'] ?? '',
      Username: json['Username'] ?? '',
      Password: json['Password'] ?? '',
      PhoneNumber: json['PhoneNumber'] ?? '',
      ImageUrl: json['AvatarUrl'] ?? json['AvtarUrl'],
      Role: json['Role'] ?? '',
      Gender: json['Gender'] ?? '',
      Age: json['Age'],
      EducationLevel: json['EducationLevel'] ?? '',
      Salary: json['Salary']?.toDouble() ?? 0.0,
      Address: json['Address'] ?? '',
      IsSynced: json['IsSynced'] ?? false,
      isdeleted: json['isdeleted'] ?? false,
      CreatedDate: json['CreatedDate'] ?? DateTime.now(),
      UpdatedDate: json['UpdatedDate'] ?? DateTime.now(),
    );
  }

  //! from object to json
  Map<String, dynamic> toJson() {
    return {
      'localId': localId,
      'Id': Id,
      'Name': Name,
      'Username': Username,
      'Password': Password,
      'PhoneNumber': PhoneNumber,
      'ImageUrl': ImageUrl,
      'Role': Role,
      'Gender': Gender,
      'Age': Age,
      'EducationLevel': EducationLevel,
      'Salary': Salary,
      'Address': Address,
      'IsSynced': IsSynced,
      'isdeleted': isdeleted,
      'CreatedDate': CreatedDate,
      'UpdatedDate': UpdatedDate,
    };
  }
}
