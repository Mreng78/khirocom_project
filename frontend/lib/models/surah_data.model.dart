class SurahData {
  int number;
  String Name;
  int Ayahs;
  SurahData({required this.number,required this.Name,required this.Ayahs});

  static List <String>surahnames(){
    return surahdata.map((e) => e.Name).toList();
  }

  static int surahindex(String name) {
    try {
      return surahdata.firstWhere((e) => e.Name == name).number;
    } catch (e) {
      return -1;
    }
  }

  static int surahayahs(String name) {
    try {
      return surahdata.firstWhere((e) => e.Name == name).Ayahs;
    } catch (e) {
      return 0; // Return 0 if not found to avoid runtime crash
    }
  }

  static String getsurahname(int index) {
    if (index < 1 || index > 114) return "";
    return surahdata[index - 1].Name;
  }

}
List<SurahData> surahdata = [
  SurahData(number: 1,Name: "الفاتحة",Ayahs: 7),
  SurahData(number: 2,Name: "البقرة",Ayahs: 286),
  SurahData(number: 3,Name: "آل عمران",Ayahs: 200),
  SurahData(number: 4,Name: "النساء",Ayahs: 176),
  SurahData(number: 5,Name: "المائدة",Ayahs: 120),
  SurahData(number: 6,Name: "الأنعام",Ayahs: 165),
  SurahData(number: 7,Name: "الأعراف",Ayahs: 206),
  SurahData(number: 8,Name: "الأنفال",Ayahs: 75),
  SurahData(number: 9,Name: "التوبة",Ayahs: 129),
  SurahData(number: 10,Name: "يونس",Ayahs: 109),
  SurahData(number: 11,Name: "هود",Ayahs: 123),
  SurahData(number: 12,Name: "يوسف",Ayahs: 111),
  SurahData(number: 13,Name: "الرعد",Ayahs: 43),
  SurahData(number: 14,Name: "إبراهيم",Ayahs: 52),
  SurahData(number: 15,Name: "الحجر",Ayahs: 99),
  SurahData(number: 16,Name: "النحل",Ayahs: 128),
  SurahData(number: 17,Name: "الإسراء",Ayahs: 111),
  SurahData(number: 18,Name: "الكهف",Ayahs: 110),
  SurahData(number: 19,Name: "مريم",Ayahs: 98),
  SurahData(number: 20,Name: "طه",Ayahs: 135),
  SurahData(number: 21,Name: "الأنبياء",Ayahs: 112),
  SurahData(number: 22,Name: "الحج",Ayahs: 78),
  SurahData(number: 23,Name: "المؤمنون",Ayahs: 118),
  SurahData(number: 24,Name: "النور",Ayahs: 64),
  SurahData(number: 25,Name: "الفرقان",Ayahs: 77),
  SurahData(number: 26,Name: "الشعراء",Ayahs: 227),
  SurahData(number: 27,Name: "النمل",Ayahs: 93),
  SurahData(number: 28,Name: "القصص",Ayahs: 88),
  SurahData(number: 29,Name: "العنكبوت",Ayahs: 69),
  SurahData(number: 30,Name: "الروم",Ayahs: 60),
  SurahData(number: 31,Name: "لقمان",Ayahs: 34),
  SurahData(number: 32,Name: "السجدة",Ayahs: 30),
  SurahData(number: 33,Name: "الأحزاب",Ayahs: 73),
  SurahData(number: 34,Name: "سبأ",Ayahs: 54),
  SurahData(number: 35,Name: "فاطر",Ayahs: 45),
  SurahData(number: 36,Name: "يس",Ayahs: 83),
  SurahData(number: 37,Name: "الصافات",Ayahs: 182),
  SurahData(number: 38,Name: "ص",Ayahs: 88),
  SurahData(number: 39,Name: "الزمر",Ayahs: 75),
  SurahData(number: 40,Name: "غافر",Ayahs: 85),
  SurahData(number: 41,Name: "فصلت",Ayahs: 54),
  SurahData(number: 42,Name: "الشورى",Ayahs: 53),
  SurahData(number: 43,Name: "الزخرف",Ayahs: 89),
  SurahData(number: 44,Name: "الدخان",Ayahs: 59),
  SurahData(number: 45,Name: "الجاثية",Ayahs: 37),
  SurahData(number: 46,Name: "الأحقاف",Ayahs: 35),
  SurahData(number: 47,Name: "محمد",Ayahs: 38),
  SurahData(number: 48,Name: "الفتح",Ayahs: 29),
  SurahData(number: 49,Name: "الحجرات",Ayahs: 18),
  SurahData(number: 50,Name: "ق",Ayahs: 45),
  SurahData(number: 51,Name: "الذاريات",Ayahs: 60),
  SurahData(number: 52,Name: "الطور",Ayahs: 49),
  SurahData(number: 53,Name: "النجم",Ayahs: 62),
  SurahData(number: 54,Name: "القمر",Ayahs: 55),
  SurahData(number: 55,Name: "الرحمن",Ayahs: 78),
  SurahData(number: 56,Name: "الواقعة",Ayahs: 96),
  SurahData(number: 57,Name: "الحديد",Ayahs: 29),
  SurahData(number: 58,Name: "المجادلة",Ayahs: 22),
  SurahData(number: 59,Name: "الحشر",Ayahs: 24),
  SurahData(number: 60,Name: "الممتحنة",Ayahs: 13),
  SurahData(number: 61,Name: "الصف",Ayahs: 14),
  SurahData(number: 62,Name: "الجمعة",Ayahs: 11),
  SurahData(number: 63,Name: "المنافقون",Ayahs: 11),
  SurahData(number: 64,Name: "التغابن",Ayahs: 18),
  SurahData(number: 65,Name: "الطلاق",Ayahs: 12),
  SurahData(number: 66,Name: "التحريم",Ayahs: 12),
  SurahData(number: 67,Name: "الملك",Ayahs: 30),
  SurahData(number: 68,Name: "القلم",Ayahs: 52),
  SurahData(number: 69,Name: "الحاقة",Ayahs: 52),
  SurahData(number: 70,Name: "المعارج",Ayahs: 44),
  SurahData(number: 71,Name: "نوح",Ayahs: 28),
  SurahData(number: 72,Name: "الجن",Ayahs: 28),
  SurahData(number: 73,Name: "المزمل",Ayahs: 20),
  SurahData(number: 74,Name: "المدثر",Ayahs: 56),
  SurahData(number: 75,Name: "القيامة",Ayahs: 40),
  SurahData(number: 76,Name: "الإنسان",Ayahs: 31),
  SurahData(number: 77,Name: "المرسلات",Ayahs: 50),
  SurahData(number: 78,Name: "النبأ",Ayahs: 40),
  SurahData(number: 79,Name: "النازعات",Ayahs: 46),
  SurahData(number: 80,Name: "عبس",Ayahs: 42),
  SurahData(number: 81,Name: "التكوير",Ayahs: 29),
  SurahData(number: 82,Name: "الانفطار",Ayahs: 19),
  SurahData(number: 83,Name: "المطففين",Ayahs: 36),
  SurahData(number: 84,Name: "الانشقاق",Ayahs: 25),
  SurahData(number: 85,Name: "البروج",Ayahs: 22),
  SurahData(number: 86,Name: "الطارق",Ayahs: 17),
  SurahData(number: 87,Name: "الأعلى",Ayahs: 19),
  SurahData(number: 88,Name: "الغاشية",Ayahs: 26),
  SurahData(number: 89,Name: "الفجر",Ayahs: 30),
  SurahData(number: 90,Name: "البلد",Ayahs: 20),
  SurahData(number: 91,Name: "الشمس",Ayahs: 15),
  SurahData(number: 92,Name: "الليل",Ayahs: 21),
  SurahData(number: 93,Name: "الضحى",Ayahs: 11),
  SurahData(number: 94,Name: "الشرح",Ayahs: 8),
  SurahData(number: 95,Name: "التين",Ayahs: 8),
  SurahData(number: 96,Name: "العلق",Ayahs: 19),
  SurahData(number: 97,Name: "القدر",Ayahs: 5),
  SurahData(number: 98,Name: "البينة",Ayahs: 8),
  SurahData(number: 99,Name: "الزلزلة",Ayahs: 8),
  SurahData(number: 100,Name: "العاديات",Ayahs: 11),
  SurahData(number: 101,Name: "القارعة",Ayahs: 11),
  SurahData(number: 102,Name: "التكاثر",Ayahs: 8),
  SurahData(number: 103,Name: "العصر",Ayahs: 3),
  SurahData(number: 104,Name: "الهمزة",Ayahs: 9),
  SurahData(number: 105,Name: "الفيل",Ayahs: 5),
  SurahData(number: 106,Name: "قريش",Ayahs: 4),
  SurahData(number: 107,Name: "المعون",Ayahs: 7),
  SurahData(number: 108,Name: "الكوثر",Ayahs: 3),
  SurahData(number: 109,Name: "الكافرون",Ayahs: 6),
  SurahData(number: 110,Name: "النصر",Ayahs: 3),
  SurahData(number: 111,Name: "المسد",Ayahs: 5),
  SurahData(number: 112,Name: "الإخلاص",Ayahs: 4),
  SurahData(number: 113,Name: "الفلق",Ayahs: 5),
  SurahData(number: 114,Name: "الناس",Ayahs: 6),
];