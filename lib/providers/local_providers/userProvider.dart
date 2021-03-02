import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:calory_calc/models/dbModels.dart';

class DBUserProvider {
  DBUserProvider._();

  static final DBUserProvider db = DBUserProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Users.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Users ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "surname TEXT,"
          "weight DOUBLE,"
          "height DOUBLE,"
          "age DOUBLE,"
          "workModel DOUBLE,"
          "gender BOOL,"
          "workFutureModel INTEGER,"
          "clickCount INTEGER"
          ")");
    });
  }

  Future<int> addUser(User user) async {
    final db = await database;
    var raw = await db.rawInsert(
      "INSERT Into Users (id, name, surname, weight, height, age, workModel, gender, workFutureModel, clickCount)"
      " VALUES (?,?,?,?,?,?,?,?,?,?)",
      [
        0,
        user.name,
        user.surname,
        user.weight,
        user.height,
        user.age,
        user.workModel,
        user.gender,
        user.workFutureModel,
        0
      ],
    );
    return raw;
  }

  Future<bool> counter() async {
    final db = await database;
    bool adResponse = false;
    var res = await db.rawQuery("SELECT * FROM Users");
    var item = res.first;
    int count = res.first['clickCount'];
    count++;
    if (count <= 20) {
      updateDateProducts('clickCount', count);
    } else {
      adResponse = true;
      updateDateProducts('clickCount', 0);
    }
    return adResponse;
  }

  Future<int> updateDateProducts(String paramName, param) async {
    final db = await database;
    int count = await db.rawUpdate(
        "UPDATE Users SET $paramName = ? WHERE id = ?", ['$param', 0]);
    return count;
  }

  Future<int> updateUser(User user) async {
    final db = await database;
    int count = await db.rawUpdate(
        'UPDATE Users SET name = ?, surname = ?, weight = ?, height = ?, age = ?, workModel = ?, gender = ?, workFutureModel = ? WHERE id = ?',
        [
          '${user.name}',
          '${user.surname}',
          '${user.weight}',
          '${user.height}',
          '${user.age}',
          '${user.workModel}',
          '${user.gender}',
          '${user.workFutureModel}',
          0
        ]);
    return count;
  }

  Future<int> updateUserOnlyNameAndSurname(
      int id, String name, String surname) async {
    final db = await database;
    int count = await db.rawUpdate(
        'UPDATE Users SET name = ?, surname = ? WHERE id = ?',
        [name, surname, id]);
    return count;
  }

  Future<User> getUser() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Users");
    if (res == null || res.isEmpty) {
      return null;
    }
    var item = res.first;
    User user = User(
      id: item['id'],
      name: item['name'],
      surname: item['surname'],
      weight: item['weight'],
      height: item['height'],
      age: item['age'],
      workModel: item['workModel'],
      gender: item['gender'] == 1,
      workFutureModel: item['workFutureModel'],
      clickCount: item['clickCount'],
    );

    return user;
  }
}
