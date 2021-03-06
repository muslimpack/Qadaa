import 'package:qadaa/manager/constant.dart';
import 'package:flutter/material.dart';

class MyTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? trailing;
  final Function onTap;

  const MyTile(
      {Key? key,
      required this.icon,
      required this.title,
      required this.onTap,
      this.trailing = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Card(
        child: ListTile(
          title: Text(title),
          leading: Icon(icon),
          trailing: Text(
            trailing ?? "",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: AppConstant.mainColorLight),
          ),
          onTap: () => onTap(),
        ),
      ),
    );
  }
}
