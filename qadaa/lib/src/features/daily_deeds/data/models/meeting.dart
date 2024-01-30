import 'dart:convert';

import 'package:flutter/material.dart';

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  final String eventName;

  /// From which is equivalent to start time property of [Appointment].
  final DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  final DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  final Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  final bool isAllDay;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'eventName': eventName,
      'from': from.millisecondsSinceEpoch,
      'to': to.millisecondsSinceEpoch,
      'background': background.value,
      'isAllDay': isAllDay,
    };
  }

  factory Meeting.fromMap(Map<String, dynamic> map) {
    return Meeting(
      map['eventName'] as String,
      DateTime.fromMillisecondsSinceEpoch(map['from'] as int),
      DateTime.fromMillisecondsSinceEpoch(map['to'] as int),
      Color(map['background'] as int),
      map['isAllDay'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Meeting.fromJson(String source) =>
      Meeting.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return toJson();
  }

  Meeting copyWith({
    String? eventName,
    DateTime? from,
    DateTime? to,
    Color? background,
    bool? isAllDay,
  }) {
    return Meeting(
      eventName ?? this.eventName,
      from ?? this.from,
      to ?? this.to,
      background ?? this.background,
      isAllDay ?? this.isAllDay,
    );
  }
}
