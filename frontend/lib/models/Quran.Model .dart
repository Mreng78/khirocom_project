import 'Aya.model.dart';

class QuranModel {
  final Map<int, List<Ayah>> surahs;

  QuranModel({required this.surahs});

  factory QuranModel.fromJson(Map<String, dynamic> json) {
    final Map<int, List<Ayah>> data = {};

    json.forEach((key, value) {
      data[int.parse(key)] =
          (value as List).map((e) => Ayah.fromJson(e)).toList();
    });

    return QuranModel(surahs: data);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    surahs.forEach((key, value) {
      data[key.toString()] =
          value.map((e) => e.toJson()).toList();
    });

    return data;
  }
}