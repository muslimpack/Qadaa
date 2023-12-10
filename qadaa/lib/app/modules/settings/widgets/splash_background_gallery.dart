import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:qadaa/core/values/constant.dart';

class SplashBackgroundGallery extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelect;
  const SplashBackgroundGallery({
    super.key,
    required this.onSelect,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          ...List.generate(
            AppConstant.splashImages.length,
            (index) {
              return Container(
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: selectedIndex != index
                      ? null
                      : Border.all(
                          color: Colors.blue,
                          width: 2,
                        ),
                ),
                child: InkWell(
                  onTap: () {
                    onSelect.call(index);
                  },
                  child: SizedBox(
                    height: 250,
                    width: 150,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                AppConstant.splashImages[index],
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                          child: Container(
                            alignment: Alignment.center,
                            child: const Text(""),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
