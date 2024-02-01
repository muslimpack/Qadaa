import 'package:flutter/material.dart';
import 'package:qadaa/src/features/daily_deeds/presentation/components/liquid_circular_progress.dart';

class StatsTile extends StatelessWidget {
  final String label;
  final double value;
  final int times;
  final int? count;
  const StatsTile({
    super.key,
    required this.label,
    required this.value,
    required this.times,
    this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 100),
            child: Text(label),
          ),
          const SizedBox(width: 10),
          Expanded(child: LinearLiquidProgress(value: value)),
          const SizedBox(width: 10),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 50),
            child: Text(
              "$times",
              textAlign: TextAlign.center,
            ),
          ),
          if (count != null) ...[
            const SizedBox(width: 10),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 50),
              child: Text(
                "$count",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
