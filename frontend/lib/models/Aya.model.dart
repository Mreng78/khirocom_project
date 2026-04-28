import 'package:frontend/models/Quran.Model%20.dart';

class PlanResult {
  final Ayah target;
  final int cycles;
  PlanResult({required this.target, this.cycles = 0});
}

class Ayah {
  final int surahNumber;
  final String surahName;
  final int verse;
  final String text;
  final int page;
  final int juz;

  Ayah({
    required this.surahNumber,
    required this.surahName,
    required this.verse,
    required this.text,
    required this.page,
    required this.juz,
  });

  factory Ayah.fromJson(Map<String, dynamic> json) {
    return Ayah(
      surahNumber: json['surahNumber'],
      surahName: json['surahName'],
      verse: json['verse'],
      text: json['text'],
      page: json['page'],
      juz: json['juz'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'surahNumber': surahNumber,
      'surahName': surahName,
      'verse': verse,
      'text': text,
      'page': page,
      'juz': juz,
    };
  }

  static PlanResult calculatePlanEnd(
    QuranModel quran,
    int startSurah,
    int startVerse,
    double dailyAmount,
    int days, {
    int? limitSurah, // السورة التي قبل الحفظ (أو حد التوقف)
  }) {
    final int targetPages = (dailyAmount * days).floor().clamp(1, 999999);
    print("CALCULATE PLAN END: targetPages=$targetPages (daily=$dailyAmount, days=$days)");
    int currentS = startSurah;
    int currentV = startVerse;
    int cycles = 0;

    int getPage(int s, int v) {
      final list = quran.surahs[s];
      if (list == null || list.isEmpty) return -1;
      return list.firstWhere((a) => a.verse == v, orElse: () => list.last).page;
    }

    int currentPage = getPage(currentS, currentV);
    int pagesCount = 1;

    while (pagesCount < targetPages) {
      final surahAyahs = quran.surahs[currentS];
      if (surahAyahs == null) break;

      if (currentV < surahAyahs.length) {
        currentV++;
      } else {
        // انتقل للسورة التالية (بالرجوع للخلف)
        int nextS = currentS - 1;
        
        // التحقق من الحد (قبل الحفظ)
        if (limitSurah != null && nextS == limitSurah) {
          nextS = 114; // العودة للسورة 114 (144 كما طلب المستخدم)
          cycles++;
        } else if (nextS < 1) {
          nextS = 114;
          cycles++;
        }
        
        currentS = nextS;
        currentV = 1;

        // Skip incrementing pagesCount for the jump itself
        final newPage = getPage(currentS, currentV);
        currentPage = newPage;
        continue; // Go to next iteration without checking page change again
      }

      final newPage = getPage(currentS, currentV);
      if (newPage != -1 && newPage != currentPage) {
        pagesCount++;
        print("Page change: $currentPage -> $newPage (count: $pagesCount) at S:$currentS V:$currentV");
        currentPage = newPage;
      }
    }
    print("FINISHED LOOP: finalS=$currentS finalV=$currentV steps=$pagesCount");

    // تعبئة بقية الصفحة الحالية لضمان الوقوف عند نهاية الصفحة
    while (true) {
      final surahAyahs = quran.surahs[currentS];
      if (surahAyahs == null) break;

      int peekS = currentS;
      int peekV = currentV;

      if (peekV < surahAyahs.length) {
        peekV++;
      } else {
        int nextS = peekS - 1;
        if (limitSurah != null && nextS == limitSurah) {
          break; // توقف عند الحد في peek أيضاً
        } else if (nextS < 1) {
          nextS = 114;
        }
        peekS = nextS;
        peekV = 1;
      }

      final peekPage = getPage(peekS, peekV);
      if (peekPage != currentPage) break;

      currentS = peekS;
      currentV = peekV;
    }

    final resultSurah = quran.surahs[currentS] ?? quran.surahs[114]!;
    final targetAyah = resultSurah.firstWhere(
      (a) => a.verse == currentV,
      orElse: () => resultSurah.last,
    );
    
    return PlanResult(target: targetAyah, cycles: cycles);
  }
  
  static int getPage(QuranModel? quran, int s, int v) {
    if (quran == null) return -1;
    final list = quran.surahs[s];
    if (list == null || list.isEmpty) return -1;
    return list.firstWhere((a) => a.verse == v, orElse: () => list.last).page;
  }
}