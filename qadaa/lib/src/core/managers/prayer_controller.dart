import 'package:get/get.dart';
import 'package:qadaa/generated/l10n.dart';
import 'package:qadaa/src/core/managers/storage_repo.dart';

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

  /// Prayers per day from settings, falling back to the default on a bad
  /// stored value instead of throwing.
  int _prayersPerDay() {
    final int? value = int.tryParse(getQadaaEveryDay());
    return (value == null || value < 1)
        ? StorageRepo.defaultQadaaEveryDay
        : value;
  }

  /// Number of days needed to make up all remaining prayers, rounded up:
  /// 7 prayers at 5 a day still takes 2 days.
  int _qadaaDaysLeft() {
    final int prayersPerDay = _prayersPerDay();
    return (getAllRemainingPrayer() + prayersPerDay - 1) ~/ prayersPerDay;
  }

  static DateTime _today() {
    final DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  /// Last day of qadaa, counting today as day 1. Uses calendar days, so
  /// daylight saving changes cannot shift the date.
  DateTime updateEndDateOfQadaa() {
    final DateTime today = _today();
    final int days = _qadaaDaysLeft();
    return DateTime(today.year, today.month, today.day + (days - 1));
  }

  String getPrayerEndDateText() {
    if (getAllRemainingPrayer() == 0) {
      return S.current.no_missed_prayer;
    }

    if (_qadaaDaysLeft() <= 1) {
      return "${S.current.completion_date}:\n ${S.current.today}";
    }

    final DateTime dueDate = updateEndDateOfQadaa();
    return '${S.current.completion_date}:\n ${dueDate.day} / ${dueDate.month} / ${dueDate.year}';
  }

  String getFastingEndDateText() {
    final int fasting = storageRepo.getFasting();
    if (fasting == 0) {
      return S.current.no_missed_fasting;
    }

    final DateTime today = _today();
    final DateTime dueDate =
        DateTime(today.year, today.month, today.day + fasting);
    return '${S.current.completion_date}: ${dueDate.day} / ${dueDate.month} / ${dueDate.year}';
  }

  Duration fastingDifference() {
    return Duration(days: storageRepo.getFasting());
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

  /// ******************************
  /// Last Updated
  /// ******************************

  String getLastUpdatedText() {
    final DateTime? lastUpdated = storageRepo.getLastUpdated();
    if (lastUpdated == null) {
      return S.current.last_updated_never;
    }

    final int? daysAgo = storageRepo.getDaysSinceLastUpdate();
    final String formattedDate = _formatDateTime(lastUpdated);
    
    if (daysAgo == null) {
      return '${S.current.last_updated}: $formattedDate';
    }

    String daysAgoText;
    if (daysAgo == 0) {
      daysAgoText = S.current.today;
    } else if (daysAgo == 1) {
      daysAgoText = S.current.yesterday;
    } else {
      final String prefix = S.current.days_ago_prefix.isNotEmpty 
          ? '${S.current.days_ago_prefix} ' 
          : '';
      final String suffix = S.current.days_ago_suffix.isNotEmpty 
          ? ' ${S.current.days_ago_suffix}' 
          : '';
      daysAgoText = '$prefix$daysAgo$suffix';
    }

    return '${S.current.last_updated}: $daysAgoText\n$formattedDate';
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
