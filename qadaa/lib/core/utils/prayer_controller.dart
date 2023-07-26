import 'package:get/get.dart';
import 'package:qadaa/core/utils/storage_repo.dart';

class PrayersController extends GetxController {
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    isLoading = false;
    update();
  }

  reset() {
    storageRepo.reset();
    update();
  }

  addPrayer(
      {int fajr = 0,
      int dhuhr = 0,
      int asr = 0,
      int maghrib = 0,
      int isha = 0}) {
    storageRepo.addPrayer(
      fajr: fajr,
      dhuhr: dhuhr,
      asr: asr,
      maghrib: maghrib,
      isha: isha,
    );
    update();
  }

  addDay({required int? value}) {
    if (value != null) {
      addPrayer(
        fajr: value,
        dhuhr: value,
        asr: value,
        maghrib: value,
        isha: value,
      );
    }
    update();
  }

  addWeek({required int? value}) {
    if (value != null) {
      addDay(value: value * 7);
    }
    update();
  }

  addMonth({required int? value}) {
    if (value != null) {
      addDay(value: value * 30);
    }
    update();
  }

  addYear({required int? value}) {
    if (value != null) {
      addDay(value: value * 365);
    }
    update();
  }

  int getDays() {
    List<int> prayerTimesForEach = [
      getFajr().toInt(),
      getDhuhr().toInt(),
      getAsr().toInt(),
      getMaghrib().toInt(),
      getIsha().toInt()
    ];
    prayerTimesForEach.sort();

    return prayerTimesForEach.first;
  }

  int getDaysMax() {
    List<int> prayerTimesForEach = [
      getMaxFajr(),
      getMaxDhuhr(),
      getMaxAsr(),
      getMaxMaghrib(),
      getMaxIsha()
    ];
    prayerTimesForEach.sort();
    if (prayerTimesForEach.last == 0) {
      return 1;
    } else {
      return prayerTimesForEach.last;
    }
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
    return storageRepo.getAsr();
  }

  int getMaxMaghrib() {
    return storageRepo.getMaxMaghrib();
  }

  int getMaxIsha() {
    return storageRepo.getMaxIsha();
  }

  int getAllRemainingPrayer() {
    return storageRepo.getAllRemainingPrayer();
  }

  DateTime updateEndDateOfQadaa() {
    DateTime? endDayOfQadaa = DateTime.now();
    int? prayersPerDay = 1;
    prayersPerDay = int.parse(getQadaaEveryDay());

    endDayOfQadaa = DateTime.now()
        .add(Duration(days: getAllRemainingPrayer() ~/ prayersPerDay));

    return endDayOfQadaa;
  }

  String getEndDateText() {
    if (getAllRemainingPrayer() == 0) {
      return "لا يوجد قضاء عليك";
    } else {
      Duration difference = updateEndDateOfQadaa().difference(DateTime.now());
      if ((difference.inHours / 24).round() == 0) {
        return "موعد انتهاء القضاء:\n اليوم إن شاء الله";
      } else {
        return 'موعد انتهاء القضاء:\n ${updateEndDateOfQadaa().day} / ${updateEndDateOfQadaa().month} / ${updateEndDateOfQadaa().year}';
      }
    }
  }

  // qadaa every day
  String getQadaaEveryDay() {
    return storageRepo.getQadaaEveryDay();
  }

  setQadaaEveryDay(String? count) {
    storageRepo.setQadaaEveryDay(count);
    update();
  }

  resetQadaaEveryDay() {
    storageRepo.resetQadaaEveryDay();
    update();
  }
}
