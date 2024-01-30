// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Dots extends StatelessWidget {
  final int length;
  final int activeIndex;
  const Dots({
    super.key,
    required this.length,
    required this.activeIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
        (index) {
          return AnimatedContainer(
            curve: Curves.bounceInOut,
            duration: const Duration(milliseconds: 250),
            height: 10,
            width: activeIndex == index ? 25 : 10,
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.pink,
            ),
          );
        },
      ),
    );
  }
}
