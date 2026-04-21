import 'package:get/get.dart';
import 'package:frontend/models/surah_data.model.dart';

class SurahController extends GetxController {
  final RxString ayatcount = "0".obs;

  String getayatcount(String name) {
    if (name.trim().isEmpty) return "0";

    final count = SurahData.surahayahs(name);
    ayatcount.value = count.toString();

    return ayatcount.value;
  }

  String getsurahname(int index) {
    if (index < 1 || index > 114) return "";
    return SurahData.surahnames()[index - 1];
  }

  List<String> getsurahnames() {
    return SurahData.surahnames();
  }

  int getsurahindex(String name) {
    if (name.trim().isEmpty) return -1;

    try {
      return SurahData.surahindex(name);
    } catch (e) {
      return -1;
    }
  }
}
