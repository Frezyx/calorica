import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:calory_calc/models/dbModels.dart';
import 'package:calory_calc/models/diet.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:calory_calc/utils/dateHelpers/dateFromInt.dart';

class DBDietProvider {
  DBDietProvider._();

  static final DBDietProvider db = DBDietProvider._();

  Database _database;
  final rng = new Random();
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }
  
  Future<int>firstCreateTable(User user) async{
    final db = await database;
    final id = 0;
    final nowDate = DateTime.now();
    final _date = DateTime(nowDate.year, nowDate.month, nowDate.day);
    final now = epochFromDate(_date);

    final raw = await db.rawInsert(
        "INSERT Into Diet (id, name, user_id, calory, squi, fat, carboh, date)"
        " VALUES (?,?,?,?,?,?,?,?)",
        [id,'Говядина отборная', user.id, 0, 0.0, 0, 0, now]
        );
    return raw;
  }


  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Diet.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Diet ("
          "id INTEGER PRIMARY KEY,"
          "user_id INTEGER,"
          "name TEXT,"
          "calory DOUBLE,"
          "squi DOUBLE,"
          "fat DOUBLE,"
          "carboh DOUBLE,"
          "date INTEGER" 
          ")");
    });
  }

  Future<Diet> getDietById(int id) async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Diet WHERE id = $id");
      var item = res.first;

      var diet = Diet(
        id: item['id'],
        name: item['name'],
        user_id: item['user_id'],
        calory: item['calory'],
        fat: item['fat'],
        squi: item['squi'],
        carboh: item['carboh'],
        date: DateTime.fromMillisecondsSinceEpoch(item['date']),
      );

    return diet;
  }

  Future<List<Diet>> getAllDiets() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Diet");
    List<Diet> list =
      res.isNotEmpty ? res.map((c) => Diet.fromMap(c)).toList() : [];

    return list;
  }

  Future<int>adddiet(Diet diet) async{
    final db = await database;
    final table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Diet");
    final id = table.first["id"];
    final nowDate = DateTime.now();
    final _date = DateTime(nowDate.year, nowDate.month, nowDate.day);
    final now = epochFromDate(_date);

    final raw = await db.rawInsert(
        "INSERT Into Diet (id, name, user_id, calory, squi, fat, carboh, date)"
        " VALUES (?,?,?,?,?,?,?,?)",
        [id, 
        diet.name,
        diet.user_id,
        diet.calory,
        diet.squi,
        diet.fat,
        diet.carboh,
        now,
        ]);

      return raw;
  }

  Future<int>updateDiet(Diet diet) async{
    final db = await database;
    final nowDate = DateTime.now();
    final _date = DateTime(nowDate.year, nowDate.month, nowDate.day);
    final now = epochFromDate(_date);

    final count = await db.rawUpdate(
      'UPDATE Diet SET name = ?, calory = ?, squi = ?, fat = ?, carboh = ?, date = ? WHERE id = ?',
      ['${diet.name}' , '${diet.calory}' , '${diet.squi}' , '${diet.fat}' , '${diet.carboh}' , '$now' , diet.id]);
    return count;
  }

}