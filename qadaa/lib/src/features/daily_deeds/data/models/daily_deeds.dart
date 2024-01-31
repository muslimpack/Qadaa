// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:qadaa/src/core/extensions/date_time.dart';
import 'package:qadaa/src/features/daily_deeds/data/models/additional_prayers.dart';
import 'package:qadaa/src/features/daily_deeds/data/models/obligatory_prayer.dart';

class DailyDeeds {
  final DailyAdditionalPrayers additionalPrayers;
  final DailyObligatoryPrayers obligatoryPrayers;
  final bool fasting;
  final DateTime date;

  DailyDeeds({
    required this.additionalPrayers,
    required this.obligatoryPrayers,
    required this.fasting,
    required this.date,
  });

  DailyDeeds.empty({
    this.fasting = false,
    required this.date,
  })  : additionalPrayers = DailyAdditionalPrayers.empty(),
        obligatoryPrayers = DailyObligatoryPrayers.empty();

  DailyDeeds copyWith({
    DailyAdditionalPrayers? additionalPrayers,
    DailyObligatoryPrayers? obligatoryPrayers,
    bool? fasting,
    DateTime? date,
  }) {
    return DailyDeeds(
      additionalPrayers: additionalPrayers ?? this.additionalPrayers,
      obligatoryPrayers: obligatoryPrayers ?? this.obligatoryPrayers,
      fasting: fasting ?? this.fasting,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      ...additionalPrayers.toMap(),
      ...obligatoryPrayers.toMap(),
      'fasting': fasting,
      'date': date.dateOnly.millisecondsSinceEpoch,
    };
  }

  factory DailyDeeds.fromMap(Map<String, dynamic> map) {
    return DailyDeeds(
      additionalPrayers: DailyAdditionalPrayers.fromMap(
        map,
      ),
      obligatoryPrayers: DailyObligatoryPrayers.fromMap(
        map,
      ),
      fasting: map['fasting'] == 1,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int).dateOnly,
    );
  }

  String toJson() => json.encode(toMap());

  factory DailyDeeds.fromJson(String source) =>
      DailyDeeds.fromMap(json.decode(source) as Map<String, dynamic>);
}
