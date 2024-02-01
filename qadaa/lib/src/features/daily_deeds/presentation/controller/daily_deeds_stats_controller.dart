import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:qadaa/generated/l10n.dart';
import 'package:qadaa/src/features/daily_deeds/data/data_source/daily_deeds_repo.dart';
import 'package:qadaa/src/features/daily_deeds/data/models/stats_model.dart';

class DailyDeedsStatisticsController extends GetxController {
  late final int totalDays;
  bool isLoading = true;
  final List<StatsElement> obligatoryElements = [];
  final List<StatsElement> additionalElements = [];
  late StatsElement fastingElement;
  static const String fastingColumn = "fasting";
  static const List<String> obligatoryColumn = [
    "fajr",
    "dhuhr",
    "asr",
    "maghrib",
    "ishaa",
  ];
  static const List<String> additionalColumn = [
    "fajrPre",
    "doha",
    "dhuhrPre",
    "dhuhrAfter",
    "asrPre",
    "maghribPre",
    "maghribAfter",
    "ishaaPre",
    "ishaaAfter",
    "nightPrayer",
  ];

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  Future loadData() async {
    totalDays = await dailyDeedsRepo.daysCount();
    await loadFasting();
    await loadObligatory();
    await loadAdditional();
    isLoading = false;
    update();
  }

  Future loadFasting() async {
    final double percentage;
    final int count;

    if (totalDays == 0) {
      percentage = 1;
      count = 0;
    } else {
      count = await dailyDeedsRepo.countNonZeroValues(fastingColumn);
      percentage = count / totalDays;
    }

    fastingElement = StatsElement(
      label: readableColumnName(fastingColumn),
      times: count,
      percentage: percentage,
    );
  }

  Future loadObligatory() async {
    for (final element in obligatoryColumn) {
      final String label = element;
      final double percentage;
      final int times;

      if (totalDays == 0) {
        percentage = 1;
        times = 0;
      } else {
        times = await dailyDeedsRepo.countNonZeroValues(label);

        percentage = times / totalDays;
      }

      obligatoryElements.add(
        StatsElement(
          label: readableColumnName(label),
          times: totalDays - times,
          percentage: percentage,
        ),
      );
    }
  }

  Future loadAdditional() async {
    for (final element in additionalColumn) {
      final String label = element;
      final double percentage;
      final int times;
      final int count;

      if (totalDays == 0) {
        percentage = 1;
        times = 0;
        count = 0;
      } else {
        count = await dailyDeedsRepo.sumColumn(label);
        times = await dailyDeedsRepo.countNonZeroValues(label);
        percentage = times / totalDays;
      }

      additionalElements.add(
        StatsElement(
          label: readableColumnName(label),
          times: times,
          percentage: percentage,
          count: count,
        ),
      );
    }
  }

  String readableColumnName(String column) {
    switch (column) {
      case "fasting":
        return S.current.fast;

      case "fajr":
        return S.current.fajr;

      case "dhuhr":
        return S.current.dhuhr;

      case "asr":
        return S.current.asr;

      case "maghrib":
        return S.current.maghrib;

      case "ishaa":
        return S.current.ishaa;

      case "fajrPre":
        return S.current.fajrPre;

      case "dhuhrPre":
        return S.current.dhuhrPre;

      case "dhuhrAfter":
        return S.current.dhuhrAfter;

      case "asrPre":
        return S.current.asrPre;

      case "maghribPre":
        return S.current.maghribPre;

      case "maghribAfter":
        return S.current.maghribAfter;

      case "ishaaPre":
        return S.current.ishaaPre;

      case "ishaaAfter":
        return S.current.ishaaAfter;

      case "doha":
        return S.current.doha;

      case "nightPrayer":
        return S.current.nightPrayer;

      default:
        return "";
    }
  }
}
