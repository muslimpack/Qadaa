import 'package:flutter/material.dart';
import 'package:qadaa/src/core/constants/constant.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            AppConstant.mainColor,
          ),
        ),
      ),
    );
  }
}
