import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qadaa/src/core/extensions/date_time.dart';
import 'package:qadaa/src/core/utils/print.dart';
import 'package:qadaa/src/features/daily_deeds/data/models/daily_deeds.dart';
import 'package:sqflite/sqflite.dart';

DailyDeedsRepo dailyDeedsRepo = DailyDeedsRepo();

class DailyDeedsRepo {
  /* ************* Variables ************* */
  static const String dbName = 'daily_deeds.db';
  static const String tableName = 'daily_deeds';

  static const int dbVersion = 1;

  /* ************* Singleton Constructor ************* */

  static DailyDeedsRepo? _databaseHelper;
  static Database? _database;

  factory DailyDeedsRepo() {
    _databaseHelper ??= DailyDeedsRepo._createInstance();
    return _databaseHelper!;
  }

  DailyDeedsRepo._createInstance();

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  /* ************* Database Creation ************* */

  // init
  Future<Database> _initDatabase() async {
    late final String path;
    if (Platform.isWindows) {
      final dbPath = (await getApplicationSupportDirectory()).path;
      path = join(dbPath, dbName);
    } else {
      final dbPath = await getDatabasesPath();
      path = join(dbPath, dbName);
    }

    return openDatabase(
      path,
      version: dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onDowngrade: _onDowngrade,
    );
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    qadaaPrint("Creating $tableName Database");
    await db.execute('''
          CREATE TABLE $tableName (
            date INTEGER PRIMARY KEY,
            fasting INTEGER,
            fajrPre INTEGER,
            dhuhrPre INTEGER,
            dhuhrAfter INTEGER,
            asrPre INTEGER,
            maghribPre INTEGER,
            maghribAfter INTEGER,
            ishaaPre INTEGER,
            ishaaAfter INTEGER,
            doha INTEGER,
            nightPrayer INTEGER,
            fajr INTEGER,
            dhuhr INTEGER,
            asr INTEGER,
            maghrib INTEGER,
            ishaa INTEGER
          )
        ''');
  }

  FutureOr<void> _onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {}

  FutureOr<void> _onDowngrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {}

  ///* ************* Functions ************* */

  Future<void> insertDailyDeeds(DailyDeeds dailyDeeds) async {
    final Database db = await database;

    await db.insert(
      tableName,
      dailyDeeds.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateDailyDeeds(DailyDeeds dailyDeeds) async {
    final Database db = await database;

    await db.update(
      tableName,
      dailyDeeds.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
      where: 'date = ?',
      whereArgs: [dailyDeeds.date.millisecondsSinceEpoch],
    );
  }

  Future<List<DailyDeeds>> getAllDailyDeeds() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);

    final deeds = List.generate(maps.length, (i) {
      return DailyDeeds.fromMap(maps[i]);
    });

    qadaaPrint("getAllDailyDeeds  ${deeds.length}");

    return deeds;
  }

  Future<List<DailyDeeds>> getAllDailyDeedsSortedByDate() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      orderBy: 'date ASC',
    );

    final deeds = List.generate(maps.length, (i) {
      return DailyDeeds.fromMap(maps[i]);
    });

    qadaaPrint("getAllDailyDeedsSortedByDate  ${deeds.length}");

    return deeds;
  }

  Future<List<DailyDeeds>> getDailyDeedsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'date >= ? AND date <= ?',
      whereArgs: [
        startDate.dateOnly.millisecondsSinceEpoch,
        endDate.dateOnly.millisecondsSinceEpoch,
      ],
    );

    final deeds = List.generate(maps.length, (i) {
      return DailyDeeds.fromMap(maps[i]);
    });

    qadaaPrint("getDailyDeedsByDateRange ${deeds.length}");

    return deeds;
  }

  Future<void> deleteAllDailyDeeds() async {
    final Database db = await database;
    await db.delete(tableName);
  }

  Future<DailyDeeds?> getDailyDeedsByDate(DateTime date) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'date = ?',
      whereArgs: [date..dateOnly.millisecondsSinceEpoch],
    );

    if (maps.isEmpty) {
      return null; // Return null if no record is found for the given date
    }

    return DailyDeeds.fromMap(maps.first);
  }

  Future<DateTime?> getLastAddedDate() async {
    final Database db = await database;

    // Use the aggregate function MAX to get the maximum date from the 'daily_deeds' table
    final maps =
        await db.rawQuery('SELECT MAX(date) as maxDate FROM $tableName');

    qadaaPrint(maps);

    if (maps.isNotEmpty) {
      // The result will contain a single row with the maximum date
      final maxDateMilliseconds = maps.first['maxDate'] as int?;
      if (maxDateMilliseconds == null) return null;
      return DateTime.fromMillisecondsSinceEpoch(maxDateMilliseconds);
    }

    return null; // Return null if the table is empty
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
