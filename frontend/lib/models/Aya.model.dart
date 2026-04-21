import 'package:frontend/models/Quran.Model%20.dart';

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

  static Ayah calculatePlanEnd(
    QuranModel quran,
    int startSurah,
    int startVerse,
    int dailyAmount,
    int days,
  ) {
   

    final int targetPages = (dailyAmount * days).clamp(1, 999999);
    int currentS = startSurah;
    int currentV = startVerse;

    
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
      } else if (currentS > 2) {
        currentS--;
        currentV = 1;
      } else {
        break; 
      }

      final newPage = getPage(currentS, currentV);
      if (newPage != -1 && newPage != currentPage) {
        pagesCount++;
        currentPage = newPage;
      }
    }

   
    while (true) {
      final surahAyahs = quran.surahs[currentS];
      if (surahAyahs == null) break;

      
      int peekS = currentS;
      int peekV = currentV;

      if (peekV < surahAyahs.length) {
        peekV++;
      } else if (peekS > 2) {
        peekS--;
        peekV = 1;
      } else {
        break; 
      }

      
      final peekPage = getPage(peekS, peekV);
      if (peekPage != currentPage) break;

      currentS = peekS;
      currentV = peekV;
    }

    final resultSurah = quran.surahs[currentS] ?? quran.surahs[2]!;
    return resultSurah.firstWhere(
      (a) => a.verse == currentV,
      orElse: () => resultSurah.last,
    );
  }
  
  static int getPage(QuranModel? quran, int s, int v) {
    if (quran == null) return -1;
    final list = quran.surahs[s];
    if (list == null || list.isEmpty) return -1;
    return list.firstWhere((a) => a.verse == v, orElse: () => list.last).page;
  }
}