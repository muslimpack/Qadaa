// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class PrayerCountSelector extends StatefulWidget {
  final Widget title;
  final Widget? info;
  final int value;
  final List<int> numbers;
  final ValueChanged<int>? onChanged;
  const PrayerCountSelector({
    super.key,
    required this.value,
    required this.numbers,
    this.onChanged,
    required this.title,
    this.info,
  });

  @override
  State<PrayerCountSelector> createState() => _PrayerCountSelectorState();
}

class _PrayerCountSelectorState extends State<PrayerCountSelector> {
  late int selectedCount;
  @override
  void initState() {
    selectedCount = widget.value;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {
      selectedCount = widget.value;
    });
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant PrayerCountSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: widget.title,
            subtitle: Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: widget.numbers
                  .map(
                    (e) => ChoiceChip(
                      label: Text(e.toString()),
                      selected: e == selectedCount,
                      onSelected: (value) {
                        setState(() {
                          selectedCount = e;
                          widget.onChanged?.call(selectedCount);
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
          if (widget.info != null) widget.info!,
        ],
      ),
    );
  }
}
