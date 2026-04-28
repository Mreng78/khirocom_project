import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

@HiveType(typeId: 14)
class Notification {
  @HiveField(0)
  String localId = uuid.v4();
  @HiveField(1)
  int? Id;
  @HiveField(2)
  String title; // Changed from Title to follow lowerCamelCase
  @HiveField(3)
  String description;
  @HiveField(4)
  DateTime date;
  @HiveField(5)
  DateTime time;
  @HiveField(6)
  String type;
  @HiveField(7)
  String forWho;
  @HiveField(8)
  bool isRead;
  @HiveField(9)
  DateTime? readAt;
  @HiveField(10)
  int? userId;
  @HiveField(11)
  int? studentId;
  @HiveField(12)
  bool isSynced;
  @HiveField(13)
  bool isDeleted;
  @HiveField(14)
  DateTime createdDate;
  @HiveField(15)
  DateTime updatedDate;

  Notification({
    required this.localId,
    this.Id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.type,
    required this.forWho,
    required this.isRead,
    this.readAt,
    this.userId,
    this.studentId,
    this.isSynced = false,
    this.isDeleted = false,
    required this.createdDate,
    required this.updatedDate,
  });

  //! Convert JSON to Notification
  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        localId: json['localId'] ?? uuid.v4(),
        Id: json["Id"] is int ? json["Id"] : int.tryParse(json["Id"]?.toString() ?? ""),
        title: json["Title"]?.toString() ?? "",
        description: json["Description"]?.toString() ?? "",
        date: json["Date"] != null ? (json["Date"] is String ? DateTime.parse(json["Date"]) : json["Date"]) : DateTime.now(),
        time: json["Time"] != null ? (json["Time"] is String ? DateTime.parse(json["Time"]) : json["Time"]) : DateTime.now(),
        type: json["Type"]?.toString() ?? "",
        forWho: json["forWho"]?.toString() ?? "",
        isRead: json["IsRead"] ?? false,
        readAt: json["ReadAt"] != null ? (json["ReadAt"] is String ? DateTime.parse(json["ReadAt"]) : json["ReadAt"]) : null,
        userId: json["UserId"] is int ? json["UserId"] : int.tryParse(json["UserId"]?.toString() ?? ""),
        studentId: json["StudentId"] is int ? json["StudentId"] : int.tryParse(json["StudentId"]?.toString() ?? ""),
        isSynced: json['IsSynced'] ?? false,
        isDeleted: json['IsDeleted'] ?? false,
        createdDate: json['CreatedDate'] != null ? (json['CreatedDate'] is String ? DateTime.parse(json['CreatedDate']) : json['CreatedDate']) : DateTime.now(),
        updatedDate: json['UpdatedDate'] != null ? (json['UpdatedDate'] is String ? DateTime.parse(json['UpdatedDate']) : json['UpdatedDate']) : DateTime.now(),
      );

  //! Convert Notification to JSON
  Map<String, dynamic> toJson() => {
        "localId": localId,
        "Id": Id,
        "Title": title, // Map back to PascalCase for backend compatibility
        "Description": description,
        "Date": date.toIso8601String(),
        "Time": time.toIso8601String(),
        "Type": type,
        "forWho": forWho,
        "IsRead": isRead,
        "ReadAt": readAt?.toIso8601String(),
        "UserId": userId,
        "StudentId": studentId,
        "IsSynced": isSynced,
        "IsDeleted": isDeleted,
        "CreatedDate": createdDate.toIso8601String(),
        "UpdatedDate": updatedDate.toIso8601String(),
      };
}
