import 'package:flutter/material.dart';

class Slot {
  Slot({
    required this.order,
    required this.title,
    required this.from,
    required this.to,
    required this.background,
    this.isAllDay = false,
  });

  final int order;

  final String title;

  final DateTime from;

  final DateTime to;

  final Color background;

  final bool isAllDay;
}
