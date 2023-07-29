import 'package:flutter/material.dart';
import 'package:qadaa/core/values/constant.dart';

class MyTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? trailing;
  final Function() onTap;

  const MyTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.trailing = "",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: ListTile(
          title: Text(title),
          leading: Icon(icon),
          trailing: Text(
            trailing ?? "",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppConstant.mainColorLight,
            ),
          ),
          onTap: () => onTap(),
        ),
      ),
    );
  }
}
