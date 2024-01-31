// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Slot extends Equatable {
  final int order;
  final DateTime id;
  final String title;
  final DateTime from;
  final DateTime to;
  final Color background;
  final bool isAllDay;

  const Slot({
    required this.order,
    required this.id,
    required this.title,
    required this.from,
    required this.to,
    required this.background,
    this.isAllDay = false,
  });

  @override
  List<Object> get props {
    return [
      order,
      title,
      from,
      to,
      background,
      isAllDay,
    ];
  }
}
