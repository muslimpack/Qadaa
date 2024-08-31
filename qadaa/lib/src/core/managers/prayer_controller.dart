import 'package:get/get.dart';
import 'package:qadaa/generated/l10n.dart';
import 'package:qadaa/src/core/managers/storage_repo.dart';
import 'package:qadaa/src/core/utils/print.dart';

class PrayersController extends GetxController {
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    isLoading = false;
    update();
  }

  Future reset() async {
    await storageRepo.reset();
    update();
  }

  Future addPrayer({
    int fajr = 0,
    int dhuhr = 0,
    int asr = 0,
    int maghrib = 0,
    int isha = 0,
  }) async {
    await storageRepo.addPrayer(
      fajr: fajr,
      dhuhr: dhuhr,
      asr: asr,
      maghrib: maghrib,
      isha: isha,
    );
    update();
  }

  Future addDay({required int? value}) async {
    if (value == null) return;
    await storageRepo.addDay(value: value);
    update();
  }

  Future addWeek({required int? value}) async {
    if (value == null) return;
    await storageRepo.addWeek(value: value);
    update();
  }

  Future addMonth({required int? value}) async {
    if (value == null) return;
    await storageRepo.addMonth(value: value);
    update();
  }

  Future addYear({required int? value}) async {
    if (value == null) return;
    await addDay(value: value * 365);
    update();
  }

  Future addFasting({required int? days}) async {
    if (days == null) return;
    await storageRepo.addFasting(days: days);
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

  Future setQadaaEveryDay(String? count) async {
    await storageRepo.setQadaaEveryDay(count);
    update();
  }

  Future resetQadaaEveryDay() async {
    await storageRepo.resetQadaaEveryDay();
    update();
  }
}
