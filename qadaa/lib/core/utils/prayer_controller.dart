import 'package:get/get.dart';
import 'package:qadaa/app/shared/functions/print.dart';
import 'package:qadaa/core/utils/storage_repo.dart';
import 'package:qadaa/generated/l10n.dart';

class PrayersController extends GetxController {
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    isLoading = false;
    update();
  }

  void reset() {
    storageRepo.reset();
    update();
  }

  void addPrayer({
    int fajr = 0,
    int dhuhr = 0,
    int asr = 0,
    int maghrib = 0,
    int isha = 0,
  }) {
    storageRepo.addPrayer(
      fajr: fajr,
      dhuhr: dhuhr,
      asr: asr,
      maghrib: maghrib,
      isha: isha,
    );
    update();
  }

  void addDay({required int? value}) {
    if (value == null) return;
    storageRepo.addDay(value: value);
    update();
  }

  void addWeek({required int? value}) {
    if (value == null) return;
    storageRepo.addWeek(value: value);
    update();
  }

  void addMonth({required int? value}) {
    if (value == null) return;
    storageRepo.addMonth(value: value);
    update();
  }

  void addYear({required int? value}) {
    if (value == null) return;
    addDay(value: value * 365);
    update();
  }

  void addFasting({required int? days}) {
    if (days == null) return;
    storageRepo.addFasting(days: days);
    update();
  }

  int getDays() {
    return storageRepo.getDays();
  }

  int getDaysMax() {
    return storageRepo.getDaysMax();
  }

  int getFajr() {
    return storageRepo.getFajr();
  }

  int getDhuhr() {
    return storageRepo.getDhuhr();
  }

  int getAsr() {
    return storageRepo.getAsr();
  }

  int getMaghrib() {
    return storageRepo.getMaghrib();
  }

  int getIsha() {
    return storageRepo.getIsha();
  }

  int getMaxFajr() {
    return storageRepo.getMaxFajr();
  }

  int getMaxDhuhr() {
    return storageRepo.getMaxDhuhr();
  }

  int getMaxAsr() {
    return storageRepo.getMaxAsr();
  }

  int getMaxMaghrib() {
    return storageRepo.getMaxMaghrib();
  }

  int getMaxIsha() {
    return storageRepo.getMaxIsha();
  }

  int getMaxFasting() {
    return storageRepo.getMaxFasting();
  }

  int getFasting() {
    return storageRepo.getFasting();
  }

  int getAllRemainingPrayer() {
    return storageRepo.getAllRemainingPrayer();
  }

  DateTime updateEndDateOfQadaa() {
    int prayersPerDay = 1;
    prayersPerDay = int.parse(getQadaaEveryDay());

    return DateTime.now()
        .add(Duration(days: getAllRemainingPrayer() ~/ prayersPerDay));
  }

  String getPrayerEndDateText() {
    final DateTime dueDate = updateEndDateOfQadaa();
    final Duration difference = dueDate.difference(DateTime.now());

    if (getAllRemainingPrayer() == 0) {
      return S.current.no_missed_prayer;
    } else {
      if ((difference.inHours / 24).round() == 0) {
        return "${S.current.completion_date}:\n ${S.current.today}";
      } else {
        return '${S.current.completion_date}:\n ${dueDate.day} / ${dueDate.month} / ${dueDate.year}';
      }
    }
  }

  String getFastingEndDateText() {
    final DateTime now = DateTime.now();
    final DateTime toDay = DateTime(
      now.year,
      now.month,
      now.day,
    );
    final DateTime dueDate =
        toDay.add(Duration(days: storageRepo.getFasting()));

    final Duration difference = dueDate.difference(toDay);
    qadaaPrint(difference);
    if (difference.inDays == 0) {
      return S.current.no_missed_prayer;
    } else {
      return '${S.current.completion_date}: ${dueDate.day} / ${dueDate.month} / ${dueDate.year}';
    }
  }

  Duration fastingDifference() {
    final DateTime now = DateTime.now();
    final DateTime toDay = DateTime(
      now.year,
      now.month,
      now.day,
    );
    final DateTime dueDate =
        toDay.add(Duration(days: storageRepo.getFasting()));

    final Duration difference = dueDate.difference(toDay);
    return difference;
  }

  // qadaa every day
  String getQadaaEveryDay() {
    return storageRepo.getQadaaEveryDay();
  }

  void setQadaaEveryDay(String? count) {
    storageRepo.setQadaaEveryDay(count);
    update();
  }

  void resetQadaaEveryDay() {
    storageRepo.resetQadaaEveryDay();
    update();
  }
}
