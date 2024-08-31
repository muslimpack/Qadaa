import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qadaa/generated/l10n.dart';
import 'package:qadaa/src/core/constants/constant.dart';
import 'package:qadaa/src/core/managers/effect_manager.dart';
import 'package:qadaa/src/core/managers/prayer_controller.dart';
import 'package:qadaa/src/core/shared/gradient_linear_progress_indicator.dart';
import 'package:qadaa/src/core/utils/print.dart';

class FastingCard extends StatelessWidget {
  final Function() onUpdate;
  const FastingCard({
    super.key,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final EffectManager effectManager = Get.put(EffectManager());
    final PrayersController prayersController = Get.put(PrayersController());
    return GestureDetector(
      onTap: () async {
        await prayersController.addFasting(days: -1);
        qadaaPrint("GestureDetector");
        await effectManager.playConfetti();
        onUpdate.call();
      },
      onLongPress: () {
        prayersController.addFasting(days: 1);
        onUpdate.call();
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).fast,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      height: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${prayersController.fastingDifference().inDays} ${S.of(context).days}",
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      height: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                prayersController.getFastingEndDateText(),
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  height: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              GradientLinearProgressIndicator(
                progressValue: prayersController.getFasting() /
                    prayersController.getMaxFasting(),
                height: 10,
                trackHeight: 5,
                backgroundColor: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    Colors.blue,
                    AppConstant.mainColor,
                  ], // Replace with your desired gradient colors.
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
