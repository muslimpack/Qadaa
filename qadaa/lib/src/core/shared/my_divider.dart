import 'package:flutter/material.dart';
import 'package:qadaa/core/values/constant.dart';

class MyDivider extends StatelessWidget {
  final String title;
  const MyDivider({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppConstant.mainColorLight,
          ),
        ),
        const SizedBox(width: 10),
        const Expanded(child: Divider()),
      ],
    );
  }
}
