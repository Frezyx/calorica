import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:calory_calc/models/dbModels.dart';

class DBUserProvider {
  DBUserProvider._();

  static final DBUserProvider db = DBUserProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
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
          "surname TEXT"
          ")");
    });
  }

  Future<int>addUser(User user) async{
    final db = await database;
    var raw = await db.rawInsert(
        "INSERT Into Users (id, name, surname)"
        " VALUES (?,?,?)",
        [0, 
        user.name,
        user.surname,
        ]);
      print(raw);
    return raw;
  }

  Future<User> getUser() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Users");
      var item = res.first;
      User user = User(
        id: item['id'],
        name: item['name'],
        surname: item['surname']
      );

    return user;
  }

}