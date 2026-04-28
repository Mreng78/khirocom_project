import 'package:frontend/models/Quran.Model%20.dart';
enum RevisionDirection { forward, backward }

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
    int? limitSurah,
    bool isReverse = false,
  }) {
    // 1. حساب إجمالي الصفحات المستهدفة
    final int targetPages = (dailyAmount * days).floor().clamp(1, 999999);
    
    int currentS = startSurah;
    int currentV = startVerse;
    int cycles = 0;
    
    int getQuickPage(int s, int v) {
      final surah = quran.surahs[s];
      if (surah == null || v > surah.length || v < 1) return -1;
      return surah[v - 1].page;
    }

    int currentPage = getQuickPage(currentS, currentV);
    int pagesCount = 1;

    // الحلقة الأساسية
    while (pagesCount < targetPages) {
      if (isReverse) {
        // حركة عكسية للمراجعة
        if (currentV > 1) {
          currentV--;
        } else {
          int nextS = currentS - 1;
          if ((limitSurah != null && nextS == limitSurah) || nextS < 1) {
            nextS = 114; 
            cycles++;
          }
          currentS = nextS;
          currentV = quran.surahs[currentS]?.length ?? 1;
        }
      } else {
        // حركة أمامية للحفظ
        final surahAyahs = quran.surahs[currentS];
        if (surahAyahs == null) break;
        if (currentV < surahAyahs.length) {
          currentV++;
        } else {
          int nextS = currentS + 1;
          if (nextS > 114) nextS = 1;
          currentS = nextS;
          currentV = 1;
        }
      }

      final newPage = getQuickPage(currentS, currentV);
      if (newPage != -1 && newPage != currentPage) {
        pagesCount++;
        currentPage = newPage;
      }
    }

    // ضمان الوقوف عند "نهاية" الصفحة (أو بدايتها في حال العكس)
    while (true) {
      int nextV = isReverse ? currentV - 1 : currentV + 1;
      int nextS = currentS;

      if (isReverse) {
        if (nextV < 1) {
          nextS = currentS - 1;
          if ((limitSurah != null && nextS == limitSurah) || nextS < 1) break;
          nextV = quran.surahs[nextS]?.length ?? 1;
        }
      } else {
        if (nextV > (quran.surahs[currentS]?.length ?? 0)) {
          nextS = currentS + 1;
          if (nextS > 114) break;
          nextV = 1;
        }
      }

      final peekPage = getQuickPage(nextS, nextV);
      if (peekPage == -1 || peekPage != currentPage) break;

      currentS = nextS;
      currentV = nextV;
    }

    final resultSurah = quran.surahs[currentS] ?? quran.surahs[114]!;
    final targetAyah = resultSurah[currentV - 1];
    return PlanResult(target: targetAyah, cycles: cycles);
  }
  
  static PlanResult calculateRevision({
    required QuranModel quran,
    required int startSurah,
    required int startVerse,
    required double dailyAmount,
    required int days,
    required RevisionDirection direction,
    bool isJuz = true,
    int? currentMemorizationSurah,
    int? currentMemorizationVerse,
  }) {
    // 1. حساب إجمالي الصفحات
    double dailyPages = isJuz ? dailyAmount * 20 : dailyAmount;
    int totalPages = (dailyPages * days).round();

    if (totalPages <= 0) {
      return PlanResult(target: quran.surahs[startSurah]![startVerse - 1]);
    }

    // 2. حساب الختمات والصفحات المتبقية
    int cycles = totalPages ~/ 604;
    int remainingPages = totalPages % 604;
    if (remainingPages == 0) {
      remainingPages = 604;
      cycles -= 1;
    }

    int currentS = startSurah;
    int currentV = startVerse;

    // Cache for performance
    final Map<String, int> pageCache = {};
    int getPageCached(int s, int v) {
      final key = "$s:$v";
      if (pageCache.containsKey(key)) return pageCache[key]!;
      final surah = quran.surahs[s];
      if (surah == null || v > surah.length || v < 1) return -1;
      final p = surah[v - 1].page;
      pageCache[key] = p;
      return p;
    }

    int currentPage = getPageCached(currentS, currentV);
    int pagesCount = 1; // نبدأ بـ 1 لأننا في أول صفحة
    int safetyCounter = 0;
    const int maxIterations = 1000000;

    // 3. التقدم آية آية
    while (pagesCount < remainingPages && safetyCounter < maxIterations) {
      safetyCounter++;

      if (direction == RevisionDirection.forward) {
        // حركة أمامية
        if (currentV < quran.surahs[currentS]!.length) {
          currentV++;
        } else {
          // الوصول لنهاية السورة
          if (currentS == 114) {
            // الوصول لسورة الناس -> العودة للحفظ الحالي
            int wrapSurah = currentMemorizationSurah ?? 1;
            if (currentMemorizationSurah != null &&
                currentMemorizationVerse != null) {
              int totalInCurrent =
                  quran.surahs[currentMemorizationSurah]!.length;
              if (currentMemorizationVerse < totalInCurrent) {
                // لم ينهِ السورة الحالية -> ننتقل للسورة التي بعدها (باتجاه 114)
                // ملحوظة: إذا كان يحفظ من 114 لـ 1، فالسورة التي "بعدها" في الترتيب الرقمي هي S+1
                wrapSurah = (currentMemorizationSurah % 114) + 1;
              }
            }
            currentS = wrapSurah;
          } else {
            currentS = (currentS % 114) + 1;
          }
          currentV = 1;
        }
      } else {
        // حركة عكسية
        if (currentV > 1) {
          currentV--;
        } else {
          currentS = currentS == 1 ? 114 : currentS - 1;
          currentV = quran.surahs[currentS]!.length;
        }
      }

      int newPage = getPageCached(currentS, currentV);
      if (newPage != -1 && newPage != currentPage) {
        pagesCount++;
        currentPage = newPage;
      }
    }

    // 4. التوقف عند نهاية الصفحة (ضمان إكمال الصفحة الحالية)
    safetyCounter = 0;
    while (safetyCounter < maxIterations) {
      safetyCounter++;
      int nextS = currentS;
      int nextV = currentV;

      if (direction == RevisionDirection.forward) {
        if (nextV < quran.surahs[currentS]!.length) {
          nextV++;
        } else {
          if (nextS == 114) {
            int wrapSurah = currentMemorizationSurah ?? 1;
            if (currentMemorizationSurah != null &&
                currentMemorizationVerse != null) {
              int totalInCurrent =
                  quran.surahs[currentMemorizationSurah]!.length;
              if (currentMemorizationVerse < totalInCurrent) {
                wrapSurah = (currentMemorizationSurah % 114) + 1;
              }
            }
            nextS = wrapSurah;
          } else {
            nextS = (nextS % 114) + 1;
          }
          nextV = 1;
        }
      } else {
        if (nextV > 1) {
          nextV--;
        } else {
          nextS = nextS == 1 ? 114 : nextS - 1;
          nextV = quran.surahs[nextS]!.length;
        }
      }

      int peekPage = getPageCached(nextS, nextV);
      if (peekPage == -1 || peekPage != currentPage) break;

      currentS = nextS;
      currentV = nextV;
    }

    final targetAyah = quran.surahs[currentS]![currentV - 1];
    return PlanResult(target: targetAyah, cycles: cycles);
  }

  static int getPage(QuranModel? quran, int s, int v) {
    if (quran == null) return -1;
    final list = quran.surahs[s];
    if (list == null || list.isEmpty) return -1;
    // Fix: Verse index should be handled safely
    if (v < 1) v = 1;
    if (v > list.length) v = list.length;
    return list[v-1].page;
  }
}