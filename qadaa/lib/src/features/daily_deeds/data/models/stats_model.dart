// ignore_for_file: public_member_api_docs, sort_constructors_first
class StatsElement {
  final String label;
  final int times;
  final int? count;
  final double percentage;

  StatsElement({
    required this.label,
    required this.times,
    required this.percentage,
    this.count,
  });
}
