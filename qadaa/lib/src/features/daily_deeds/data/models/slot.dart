// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  @override
  String toString() {
    return 'Slot(order: $order, title: $title, from: $from, to: $to, background: $background, isAllDay: $isAllDay)';
  }
}
