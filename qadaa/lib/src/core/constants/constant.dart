import 'package:flutter/material.dart';

AppConstant appConstant = AppConstant();

class AppConstant {
  static Color mainColor = Colors.pink;
  static Color mainColorLight = Colors.pinkAccent;
  static Color scrollColor = Colors.black;

  //TODO edit every release
  static String get appVersion => appVersions.first;
  static List<String> appVersions = [
    "1.6.0",
    "1.5.0",
    "1.4.0",
    "1.3.0",
    "1.2.0",
    "1.1.0",
    "1.0.0",
  ];

  static List<String> notificationBody = [
    "قم وأري الله من نفسك خيرا",
    "القضاء يرحمك الله",
    "أحيي ليلك بفائتك",
  ];

  static List<String> motivateMsg = [
    "أحسنت 💪",
    "تقبل الله صالح أعمالك",
    "بارك الله فيك",
    "أعانك الله",
    "اللهم أعني على ذكرك وشكرك وحسن عبادتك",
  ];

  static List<String> splashMsg = [
    "عَنْ عَائِشَةَ أَنَّ رَسُولَ اللَّهِ صَلَّى اللَّهم عَلَيْهِ وَسَلَّمَ قَال\nَ سَدِّدُوا وَقَارِبُوا وَاعْلَمُوا أَنْ لَنْ يُدْخِلَ أَحَدَكُمْ عَمَلُهُ الْجَنَّةَ \nوَأَنَّ أَحَبَّ الْأَعْمَالِ إِلَى اللَّهِ أَدْوَمُهَا وَإِنْ قَلَّ ",
    "اتْلُ مَا أُوحِيَ إِلَيْكَ مِنَ الْكِتَابِ وَأَقِمِ الصَّلَاةَ ۖ إِنَّ الصَّلَاةَ تَنْهَىٰ عَنِ الْفَحْشَاءِ وَالْمُنكَرِ ۗ وَلَذِكْرُ اللَّهِ أَكْبَرُ ۗ وَاللَّهُ يَعْلَمُ مَا تَصْنَعُونَ",
    "بين الرجل وبين الكفر ترك الصلاة",
    "العهد الذي بيننا وبينهم الصلاة، فمن تركها فقد كفر",
    "أثقل صلاة على المنافقين صلاة الفجر وصلاة العشاء",
    "من ترك صلاة العصر -أي: متعمداً- فقد حبط عمله",
    "من سره أن يلقى الله تعالى غداً مسلماً فليحافظ على هؤلاء الصلوات حيث ينادى بهن، فإنهن من سنن الهدى",
  ];

  static List<String> splashImages = [
    "assets/images/2.jpg",
    "assets/images/0.jpg",
    "assets/images/1.jpg",
    "assets/images/3.jpg",
    "assets/images/4.jpg",
  ];
}
