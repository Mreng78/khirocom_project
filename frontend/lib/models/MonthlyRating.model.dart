import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

@HiveType(typeId: 10)
class MonthlyRating {
  @HiveField(0)
  String localId = uuid.v4();
  @HiveField(1)
  int? Id;
  @HiveField(1)
  double Memoisation_degree;
  @HiveField(2)
  double Telawah_degree;
  @HiveField(3)
  double Tajweed_degree;
  @HiveField(4)
  double Motoon_degree;
  @HiveField(5)
  double Total_degree;
  @HiveField(6)
  double Average;
  @HiveField(7)
  String? Notes;
  @HiveField(8)
  int StudentId;
  @HiveField(9)
  int MentorVisetId;
  @HiveField(10)
  bool IsSynced;
  @HiveField(11)
  bool IsDeleted;
  @HiveField(12)
  DateTime CreatedDate;
  @HiveField(13)
  DateTime UpdatedDate;

  MonthlyRating({
    required this.localId,
    this.Id,
    required this.Memoisation_degree,
    required this.Telawah_degree,
    required this.Tajweed_degree,
    required this.Motoon_degree,
    required this.Total_degree,
    required this.Average,
    this.Notes,
    required this.StudentId,
    required this.MentorVisetId,
    required this.IsSynced,
    required this.IsDeleted,
    required this.CreatedDate,
    required this.UpdatedDate,
  });

  //! Convert JSON to MonthlyRating
  factory MonthlyRating.fromJson(Map<String, dynamic> json) => MonthlyRating(
    localId: json['localId'] ?? uuid.v4(),
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
    IsSynced: json['IsSynced'] ?? false,
    IsDeleted: json['IsDeleted'] ?? false,
    CreatedDate: json['CreatedDate'] ?? DateTime.now(),
    UpdatedDate: json['UpdatedDate'] ?? DateTime.now(),
  );

  //! Convert MonthlyRating to JSON
  Map<String, dynamic> toJson() => {
    "localId": localId,
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
    'IsSynced': IsSynced,
    'IsDeleted': IsDeleted,
    'CreatedDate': CreatedDate,
    'UpdatedDate': UpdatedDate,
  };
}
