import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DailyAdditionalPrayers {
  final bool fajrPre;
  final bool dhuhrPre;
  final bool dhuhrAfter;
  final bool asrPre;
  final bool maghribPre;
  final bool maghribAfter;
  final bool ishaaPre;
  final bool ishaaAfter;
  final bool doha;
  final bool nightPrayer;

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

  DailyAdditionalPrayers copyWith({
    bool? fajrPre,
    bool? dhuhrPre,
    bool? dhuhrAfter,
    bool? asrPre,
    bool? maghribPre,
    bool? maghribAfter,
    bool? ishaaPre,
    bool? ishaaAfter,
    bool? doha,
    bool? nightPrayer,
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
      fajrPre: map['fajrPre'] as bool,
      dhuhrPre: map['dhuhrPre'] as bool,
      dhuhrAfter: map['dhuhrAfter'] as bool,
      asrPre: map['asrPre'] as bool,
      maghribPre: map['maghribPre'] as bool,
      maghribAfter: map['maghribAfter'] as bool,
      ishaaPre: map['ishaaPre'] as bool,
      ishaaAfter: map['ishaaAfter'] as bool,
      doha: map['doha'] as bool,
      nightPrayer: map['nightPrayer'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory DailyAdditionalPrayers.fromJson(String source) =>
      DailyAdditionalPrayers.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}
