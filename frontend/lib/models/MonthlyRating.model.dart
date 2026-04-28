import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

@HiveType(typeId: 10)
class MonthlyRating {
  @HiveField(0)
  String localId = uuid.v4();
  @HiveField(1)
  int? Id;
  @HiveField(2)
  double memoisationDegree;
  @HiveField(3)
  double telawahDegree;
  @HiveField(4)
  double tajweedDegree;
  @HiveField(5)
  double motoonDegree;
  @HiveField(6)
  double totalDegree;
  @HiveField(7)
  double average;
  @HiveField(8)
  String? notes;
  @HiveField(9)
  int studentId;
  @HiveField(10)
  int mentorVisetId;
  @HiveField(11)
  bool isSynced;
  @HiveField(12)
  bool isDeleted;
  @HiveField(13)
  DateTime createdDate;
  @HiveField(14)
  DateTime updatedDate;

  MonthlyRating({
    required this.localId,
    this.Id,
    required this.memoisationDegree,
    required this.telawahDegree,
    required this.tajweedDegree,
    required this.motoonDegree,
    required this.totalDegree,
    required this.average,
    this.notes,
    required this.studentId,
    required this.mentorVisetId,
    this.isSynced = false,
    this.isDeleted = false,
    required this.createdDate,
    required this.updatedDate,
  });

  //! Convert JSON to MonthlyRating
  factory MonthlyRating.fromJson(Map<String, dynamic> json) => MonthlyRating(
        localId: json['localId'] ?? uuid.v4(),
        Id: json["Id"] is int ? json["Id"] : int.tryParse(json["Id"]?.toString() ?? ""),
        memoisationDegree: json["Memoisation_degree"]?.toDouble() ?? 0.0,
        telawahDegree: json["Telawah_degree"]?.toDouble() ?? 0.0,
        tajweedDegree: json["Tajweed_degree"]?.toDouble() ?? 0.0,
        motoonDegree: json["Motoon_degree"]?.toDouble() ?? 0.0,
        totalDegree: json["Total_degree"]?.toDouble() ?? 0.0,
        average: json["Average"]?.toDouble() ?? 0.0,
        notes: json["Notes"]?.toString() ?? "",
        studentId: json["StudentId"] is int ? json["StudentId"] : int.tryParse(json["StudentId"]?.toString() ?? "0") ?? 0,
        mentorVisetId: json["MentorVisetId"] is int ? json["MentorVisetId"] : int.tryParse(json["MentorVisetId"]?.toString() ?? "0") ?? 0,
        isSynced: json['IsSynced'] ?? false,
        isDeleted: json['IsDeleted'] ?? false,
        createdDate: json['CreatedDate'] != null ? (json['CreatedDate'] is String ? DateTime.parse(json['CreatedDate']) : json['CreatedDate']) : DateTime.now(),
        updatedDate: json['UpdatedDate'] != null ? (json['UpdatedDate'] is String ? DateTime.parse(json['UpdatedDate']) : json['UpdatedDate']) : DateTime.now(),
      );

  //! Convert MonthlyRating to JSON
  Map<String, dynamic> toJson() => {
        "localId": localId,
        "Id": Id,
        "Memoisation_degree": memoisationDegree,
        "Telawah_degree": telawahDegree,
        "Tajweed_degree": tajweedDegree,
        "Motoon_degree": motoonDegree,
        "Total_degree": totalDegree,
        "Average": average,
        "Notes": notes,
        "StudentId": studentId,
        "MentorVisetId": mentorVisetId,
        'IsSynced': isSynced,
        'IsDeleted': isDeleted,
        'CreatedDate': createdDate.toIso8601String(),
        'UpdatedDate': updatedDate.toIso8601String(),
      };
}
