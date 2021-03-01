import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:calory_calc/models/dbModels.dart';

class DBProductProvider {
  DBProductProvider._();

  static final DBProductProvider db = DBProductProvider._();

  Database _database;
  var rng = Random();
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  firstCreateTable() async {
    final db = await database;
    int id = 0;
    var raw = await db.rawInsert(
        "INSERT Into Products (id, name, category, calory, squi, fat, carboh)"
        " VALUES (?,?,?,?,?,?,?)",
        [id, 'Говядина отборная', 'Говядина и телятина', 218, 18.6, 16, 0]);
    return (raw);
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Products.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Products ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "category TEXT,"
          "calory DOUBLE,"
          "squi DOUBLE,"
          "fat DOUBLE,"
          "carboh DOUBLE"
          ")");
    });
  }

  Future<int> addProduct(Product product) async {
    final db = await database;
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Products");
    int id = table.first["id"];
    var raw = await db.rawInsert(
        "INSERT Into Products (id, name, category, calory, squi, fat, carboh)"
        " VALUES (?,?,?,?,?,?,?)",
        [
          id,
          product.name,
          product.category,
          product.calory,
          product.squi,
          product.fat,
          product.carboh,
        ]);
    return id;
  }

  Future<Product> getProductById(int id) async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Products WHERE id = $id");
    var item = res.first;
    Product product = Product(
      id: item["id"],
      name: item["name"],
      category: item["category"],
      calory: item["calory"],
      squi: item["squi"],
      fat: item["fat"],
      carboh: item["carboh"],
    );

    return product;
  }

  Future<List<Product>> getAllProductsSearch(String text) async {
    final db = await database;
    var res = await db
        .query("Products", where: "name LIKE ?", whereArgs: ["%$text%"]);
    List<Product> list =
        res.isNotEmpty ? res.map((c) => Product.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Product>> getAllProducts() async {
    var rnd = Random();
    var offset = rnd.nextInt(7000);
    final db = await database;
    var res =
        await db.rawQuery("SELECT * FROM Products LIMIT 20 OFFSET '$offset'");
    List<Product> list =
        res.isNotEmpty ? res.map((c) => Product.fromMap(c)).toList() : [];
    return list;
  }
}
