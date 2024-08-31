import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qadaa/src/core/extensions/extension_platform.dart';
import 'package:qadaa/src/features/ui/presentation/components/windows_button.dart';
import 'package:window_manager/window_manager.dart';

class UIAppBar extends StatefulWidget {
  final BuildContext? shellContext;

  const UIAppBar({super.key, this.shellContext});

  @override
  State<UIAppBar> createState() => _UIAppBarState();
}

class _UIAppBarState extends State<UIAppBar> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        padding: const EdgeInsets.only(left: 10),
        height: kToolbarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (kIsWeb)
              const Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text("الأذكار النووية"),
              ),
            if (PlatformExtension.isDesktop)
              const Expanded(
                child: DragToMoveArea(
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text("الأذكار النووية"),
                  ),
                ),
              ),
            if (!kIsWeb) const WindowButtons(),
          ],
        ),
      ),
    );
  }
}
