import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DailyAdditionalPrayers {
  final int fajrPre;
  final int dhuhrPre;
  final int dhuhrAfter;
  final int asrPre;
  final int maghribPre;
  final int maghribAfter;
  final int ishaaPre;
  final int ishaaAfter;
  final int doha;
  final int nightPrayer;

  DailyAdditionalPrayers({
    required this.fajrPre,
    required this.dhuhrPre,
    required this.dhuhrAfter,
    required this.asrPre,
    required this.maghribPre,
    required this.maghribAfter,
    required this.ishaaPre,
    required this.ishaaAfter,
    required this.doha,
    required this.nightPrayer,
  });
  DailyAdditionalPrayers.empty({
    this.fajrPre = 0,
    this.dhuhrPre = 0,
    this.dhuhrAfter = 0,
    this.asrPre = 0,
    this.maghribPre = 0,
    this.maghribAfter = 0,
    this.ishaaPre = 0,
    this.ishaaAfter = 0,
    this.doha = 0,
    this.nightPrayer = 0,
  });

  DailyAdditionalPrayers copyWith({
    int? fajrPre,
    int? dhuhrPre,
    int? dhuhrAfter,
    int? asrPre,
    int? maghribPre,
    int? maghribAfter,
    int? ishaaPre,
    int? ishaaAfter,
    int? doha,
    int? nightPrayer,
  }) {
    return DailyAdditionalPrayers(
      fajrPre: fajrPre ?? this.fajrPre,
      dhuhrPre: dhuhrPre ?? this.dhuhrPre,
      dhuhrAfter: dhuhrAfter ?? this.dhuhrAfter,
      asrPre: asrPre ?? this.asrPre,
      maghribPre: maghribPre ?? this.maghribPre,
      maghribAfter: maghribAfter ?? this.maghribAfter,
      ishaaPre: ishaaPre ?? this.ishaaPre,
      ishaaAfter: ishaaAfter ?? this.ishaaAfter,
      doha: doha ?? this.doha,
      nightPrayer: nightPrayer ?? this.nightPrayer,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fajrPre': fajrPre,
      'dhuhrPre': dhuhrPre,
      'dhuhrAfter': dhuhrAfter,
      'asrPre': asrPre,
      'maghribPre': maghribPre,
      'maghribAfter': maghribAfter,
      'ishaaPre': ishaaPre,
      'ishaaAfter': ishaaAfter,
      'doha': doha,
      'nightPrayer': nightPrayer,
    };
  }

  factory DailyAdditionalPrayers.fromMap(Map<String, dynamic> map) {
    return DailyAdditionalPrayers(
      fajrPre: map['fajrPre'] as int,
      dhuhrPre: map['dhuhrPre'] as int,
      dhuhrAfter: map['dhuhrAfter'] as int,
      asrPre: map['asrPre'] as int,
      maghribPre: map['maghribPre'] as int,
      maghribAfter: map['maghribAfter'] as int,
      ishaaPre: map['ishaaPre'] as int,
      ishaaAfter: map['ishaaAfter'] as int,
      doha: map['doha'] as int,
      nightPrayer: map['nightPrayer'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory DailyAdditionalPrayers.fromJson(String source) =>
      DailyAdditionalPrayers.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}
