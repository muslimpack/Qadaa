import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
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

    return List.generate(maps.length, (i) {
      return DailyDeeds.fromMap(maps[i]);
    });
  }

  Future<List<DailyDeeds>> getAllDailyDeedsSortedByDate() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      orderBy: 'date ASC',
    );

    return List.generate(maps.length, (i) {
      return DailyDeeds.fromMap(maps[i]);
    });
  }

  Future<List<DailyDeeds>> getDailyDeedsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'date BETWEEN ? AND ?',
      whereArgs: [
        startDate.millisecondsSinceEpoch,
        endDate.millisecondsSinceEpoch,
      ],
    );

    return List.generate(maps.length, (i) {
      return DailyDeeds.fromMap(maps[i]);
    });
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
