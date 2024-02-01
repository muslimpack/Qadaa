import 'package:flutter/material.dart';

class StatsCardHeader extends StatelessWidget {
  final List<Widget> children;
  const StatsCardHeader({
    super.key,
    required this.children,
  });

  StatsCardHeader.labels({
    super.key,
    required List<String> labels,
  }) : children = labels.map((e) => Text(e)).toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
        const Divider(),
      ],
    );
  }
}
