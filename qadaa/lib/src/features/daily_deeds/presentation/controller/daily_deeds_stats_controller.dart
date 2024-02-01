import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:qadaa/src/features/daily_deeds/data/data_source/daily_deeds_repo.dart';
import 'package:qadaa/src/features/daily_deeds/data/models/stats_model.dart';

class DailyDeedsStatisticsController extends GetxController {
  late final int totalDays;
  bool isLoading = true;
  List<StatsElement> obligatoryElements = [];
  List<StatsElement> additional = [];
  static const List<String> obligatoryColumn = [
    "fajr",
    "dhuhr",
    "asr",
    "maghrib",
    "ishaa",
  ];
  static const List<String> additionalColumn = [
    "fajrPre",
    "dhuhrPre",
    "dhuhrAfter",
    "asrPre",
    "maghribPre",
    "maghribAfter",
    "ishaaPre",
    "ishaaAfter",
    "doha",
    "nightPrayer",
  ];

  @override
  void onInit() {
    loadData();

    super.onInit();
  }

  Future loadData() async {
    totalDays = await dailyDeedsRepo.daysCount();
    await loadObligatory();
    await loadAdditional();
    isLoading = false;
    update();
  }

  Future loadObligatory() async {
    for (final element in obligatoryColumn) {
      final String label = element;
      final double percentage;
      final int count;

      if (totalDays == 0) {
        percentage = 1;
        count = 0;
      } else {
        count = await dailyDeedsRepo.countNonZeroValues(label);
        percentage = count / totalDays;
      }

      obligatoryElements.add(
        StatsElement(label: label, count: count, percentage: percentage),
      );
    }
  }

  Future loadAdditional() async {}
}
