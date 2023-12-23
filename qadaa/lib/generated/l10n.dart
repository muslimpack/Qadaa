// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Qadaa`
  String get qadaa {
    return Intl.message(
      'Qadaa',
      name: 'qadaa',
      desc: '',
      args: [],
    );
  }

  /// `Remaining Days`
  String get remaining_days {
    return Intl.message(
      'Remaining Days',
      name: 'remaining_days',
      desc: '',
      args: [],
    );
  }

  /// `Fajr`
  String get fajr {
    return Intl.message(
      'Fajr',
      name: 'fajr',
      desc: '',
      args: [],
    );
  }

  /// `Dhuhr`
  String get dhuhr {
    return Intl.message(
      'Dhuhr',
      name: 'dhuhr',
      desc: '',
      args: [],
    );
  }

  /// `Asr`
  String get asr {
    return Intl.message(
      'Asr',
      name: 'asr',
      desc: '',
      args: [],
    );
  }

  /// `Maghrib`
  String get maghrib {
    return Intl.message(
      'Maghrib',
      name: 'maghrib',
      desc: '',
      args: [],
    );
  }

  /// `Ishaa`
  String get ishaa {
    return Intl.message(
      'Ishaa',
      name: 'ishaa',
      desc: '',
      args: [],
    );
  }

  /// `Fast`
  String get fast {
    return Intl.message(
      'Fast',
      name: 'fast',
      desc: '',
      args: [],
    );
  }

  /// `Days`
  String get days {
    return Intl.message(
      'Days',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Missed Prayer`
  String get missed_prayer {
    return Intl.message(
      'Missed Prayer',
      name: 'missed_prayer',
      desc: '',
      args: [],
    );
  }

  /// `No Missed Prayer`
  String get no_missed_prayer {
    return Intl.message(
      'No Missed Prayer',
      name: 'no_missed_prayer',
      desc: '',
      args: [],
    );
  }

  /// `Completion Date`
  String get completion_date {
    return Intl.message(
      'Completion Date',
      name: 'completion_date',
      desc: '',
      args: [],
    );
  }

  /// `Enter Password`
  String get enter_password {
    return Intl.message(
      'Enter Password',
      name: 'enter_password',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done_prayer {
    return Intl.message(
      'Done',
      name: 'done_prayer',
      desc: '',
      args: [],
    );
  }

  /// `New Prayer`
  String get new_prayer {
    return Intl.message(
      'New Prayer',
      name: 'new_prayer',
      desc: '',
      args: [],
    );
  }

  /// `Add Time`
  String get periods_title {
    return Intl.message(
      'Add Time',
      name: 'periods_title',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get periods_done_title {
    return Intl.message(
      'Time',
      name: 'periods_done_title',
      desc: '',
      args: [],
    );
  }

  /// `Day`
  String get day {
    return Intl.message(
      'Day',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `Week`
  String get week {
    return Intl.message(
      'Week',
      name: 'week',
      desc: '',
      args: [],
    );
  }

  /// `Month`
  String get month {
    return Intl.message(
      'Month',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `Year`
  String get year {
    return Intl.message(
      'Year',
      name: 'year',
      desc: '',
      args: [],
    );
  }

  /// `Add Prayers`
  String get prayers_title {
    return Intl.message(
      'Add Prayers',
      name: 'prayers_title',
      desc: '',
      args: [],
    );
  }

  /// `Prayers`
  String get prayers_done_title {
    return Intl.message(
      'Prayers',
      name: 'prayers_done_title',
      desc: '',
      args: [],
    );
  }

  /// `Custom Add Prayers`
  String get custom_add_prayers {
    return Intl.message(
      'Custom Add Prayers',
      name: 'custom_add_prayers',
      desc: '',
      args: [],
    );
  }

  /// `Custom Add Period`
  String get custom_add_period {
    return Intl.message(
      'Custom Add Period',
      name: 'custom_add_period',
      desc: '',
      args: [],
    );
  }

  /// `Custom Done Prayers`
  String get custom_done_prayers {
    return Intl.message(
      'Custom Done Prayers',
      name: 'custom_done_prayers',
      desc: '',
      args: [],
    );
  }

  /// `Custom Add Period`
  String get custom_done_period {
    return Intl.message(
      'Custom Add Period',
      name: 'custom_done_period',
      desc: '',
      args: [],
    );
  }

  /// `ALert`
  String get alert {
    return Intl.message(
      'ALert',
      name: 'alert',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to reset everything?`
  String get sure_to_reset_everything_msg {
    return Intl.message(
      'Are you sure you want to reset everything?',
      name: 'sure_to_reset_everything_msg',
      desc: '',
      args: [],
    );
  }

  /// `Reset everything`
  String get reset_everything {
    return Intl.message(
      'Reset everything',
      name: 'reset_everything',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start {
    return Intl.message(
      'Start',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `App Lock`
  String get app_lock {
    return Intl.message(
      'App Lock',
      name: 'app_lock',
      desc: '',
      args: [],
    );
  }

  /// `Activate App Lock`
  String get activate_app_lock {
    return Intl.message(
      'Activate App Lock',
      name: 'activate_app_lock',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get app_lock_reset_password {
    return Intl.message(
      'Reset Password',
      name: 'app_lock_reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Default Password`
  String get app_lock_default_password {
    return Intl.message(
      'Default Password',
      name: 'app_lock_default_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter Old Password`
  String get app_lock_enter_old_password {
    return Intl.message(
      'Enter Old Password',
      name: 'app_lock_enter_old_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter New Password`
  String get app_lock_enter_new_password {
    return Intl.message(
      'Enter New Password',
      name: 'app_lock_enter_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Password Reset Done`
  String get app_lock_password_reset_done {
    return Intl.message(
      'Password Reset Done',
      name: 'app_lock_password_reset_done',
      desc: '',
      args: [],
    );
  }

  /// `Prayer Settings`
  String get prayer_Settings {
    return Intl.message(
      'Prayer Settings',
      name: 'prayer_Settings',
      desc: '',
      args: [],
    );
  }

  /// `UI`
  String get ui {
    return Intl.message(
      'UI',
      name: 'ui',
      desc: '',
      args: [],
    );
  }

  /// `Splash Background`
  String get splash_background {
    return Intl.message(
      'Splash Background',
      name: 'splash_background',
      desc: '',
      args: [],
    );
  }

  /// `others`
  String get other_settings {
    return Intl.message(
      'others',
      name: 'other_settings',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message(
      'Version',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `Random Image`
  String get splash_random_image {
    return Intl.message(
      'Random Image',
      name: 'splash_random_image',
      desc: '',
      args: [],
    );
  }

  /// `Static Image`
  String get splash_static_image {
    return Intl.message(
      'Static Image',
      name: 'splash_static_image',
      desc: '',
      args: [],
    );
  }

  /// `Static color`
  String get splash_static_color {
    return Intl.message(
      'Static color',
      name: 'splash_static_color',
      desc: '',
      args: [],
    );
  }

  /// `Prayers to do a day`
  String get prayers_to_do_per_day {
    return Intl.message(
      'Prayers to do a day',
      name: 'prayers_to_do_per_day',
      desc: '',
      args: [],
    );
  }

  /// `Open in Google Play`
  String get open_in_google_play {
    return Intl.message(
      'Open in Google Play',
      name: 'open_in_google_play',
      desc: '',
      args: [],
    );
  }

  /// `Add Day`
  String get add_day {
    return Intl.message(
      'Add Day',
      name: 'add_day',
      desc: '',
      args: [],
    );
  }

  /// `Add Days`
  String get add_days {
    return Intl.message(
      'Add Days',
      name: 'add_days',
      desc: '',
      args: [],
    );
  }

  /// `Done Day`
  String get done_day {
    return Intl.message(
      'Done Day',
      name: 'done_day',
      desc: '',
      args: [],
    );
  }

  /// `Done Days`
  String get done_days {
    return Intl.message(
      'Done Days',
      name: 'done_days',
      desc: '',
      args: [],
    );
  }

  /// `Make up Missed Prayers`
  String get make_up_missed_prayers {
    return Intl.message(
      'Make up Missed Prayers',
      name: 'make_up_missed_prayers',
      desc: '',
      args: [],
    );
  }

  /// `App Language`
  String get app_lang {
    return Intl.message(
      'App Language',
      name: 'app_lang',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'bn', countryCode: 'IN'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'ur', countryCode: 'IN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
