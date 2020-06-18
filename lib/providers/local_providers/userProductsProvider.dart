import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:calory_calc/models/dateAndCalory.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:calory_calc/models/dbModels.dart';
import 'package:calory_calc/utils/dateHelpers/dateFromInt.dart';

class DBUserProductsProvider {
  DBUserProductsProvider._();

  static final DBUserProductsProvider db = DBUserProductsProvider._();

  Database _database;
  var rng = new Random();
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }
  
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "UserProducts.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE UserProducts ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "category TEXT,"
          "calory DOUBLE,"
          "squi DOUBLE,"
          "fat DOUBLE,"
          "carboh DOUBLE,"
          "date INTEGER,"
          "grams DOUBLE,"
          "productId INTEGER" 
          ")");
    });
  }

//TODO: delete
  Future<DateAndCalory>addProduct(UserProduct product) async{
    final db = await database;

    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM UserProducts");
    int id = table.first["id"];
    
    var nowDate = DateTime.now();
    var _date = DateTime(nowDate.year, nowDate.month, nowDate.day);

    int now = epochFromDate(_date);

    var raw = await db.rawInsert(
        "INSERT Into UserProducts (id, name, category, calory, squi, fat, carboh, date, grams, productId)"
        " VALUES (?,?,?,?,?,?,?,?,?,?)",
        [id, 
        product.name,
        product.category,
        product.calory,
        product.squi,
        product.fat,
        product.carboh,
        now,
        product.grams,
        product.productId
        ]);

    return DateAndCalory(id:id, date: _date);
  }

    addProductWithDate(UserProduct product) async{
    final db = await database;

    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM UserProducts");
    int id = table.first["id"];
    
    int now = epochFromDate(product.date);

    var raw = await db.rawInsert(
        "INSERT Into UserProducts (id, name, category, calory, squi, fat, carboh, date, grams, productId)"
        " VALUES (?,?,?,?,?,?,?,?,?,?)",
        [id, 
        product.name,
        product.category,
        product.calory,
        product.squi,
        product.fat,
        product.carboh,
        now,
        product.grams,
        product.productId
        ]);
  }

  Future<UserProduct> getProductById(int id) async {
    final db = await database;

    var res = await db.rawQuery("SELECT * FROM UserProducts WHERE id = $id");
      var item = res.first;

      UserProduct product = UserProduct(
        id: item["id"],
        name: item["name"],
        category: item["category"],
        calory: item["calory"],
        squi: item["squi"],
        fat: item["fat"],
        carboh: item["carboh"],
        date: DateTime.fromMillisecondsSinceEpoch(item["date"]),
        grams: item["grams"],
        productId: item["productId"],
      );

    return product;
  }

  Future<bool>updateProduct(UserProduct product) async{
    final db = await database;
    int count = await db.rawUpdate(
      'UPDATE UserProducts SET name = ?, category = ?, calory = ?, squi = ?, fat = ?, carboh = ?, date = ?, grams = ?, productId = ? WHERE id = ?',
      ['${product.name}' , '${product.category}', '${product.calory}', '${product.squi}', '${product.fat}', '${product.carboh}',
       '${epochFromDate(product.date)}', '${product.grams}', '${product.productId}', '${product.id}',]);
    return count == 1;
  }

  
  Future<List<UserProduct>> getTodayProducts() async{
    var nowDate = DateTime.now();
    var date = DateTime(nowDate.year, nowDate.month, nowDate.day);

    int now = epochFromDate(date);

    return await getProductsByDate(now);
  }

  Future<List<UserProduct>> getYesterdayProducts() async{
    final now = DateTime.now();
    int yesterday = epochFromDate(DateTime(now.year, now.month, now.day - 1));

    return await getProductsByDate(yesterday);
  }

  Future<List<UserProduct>> getProductsByDate(int date) async {
        final db = await database;

        var res = await db.rawQuery("SELECT * FROM UserProducts WHERE date = '$date'");

        List<UserProduct> list =
            res.isNotEmpty ? res.map((c) => UserProduct.fromMap(c)).toList() : [];
        return list;
      }

  deleteAll() async {
    final db = await database;
    db.rawQuery("DELETE FROM UserProducts");
  }

  Future<int>deleteById(int id) async {
    final db = await database;
    var res = await db.rawQuery("DELETE FROM UserProducts WHERE id = '$id'");
    return res.length;
  }

  Future<List<UserProduct>> getAllProducts() async {
        final db = await database;

        final now = DateTime.now();
        int today = epochFromDate(DateTime(now.year, now.month, now.day));

        var res = await db.rawQuery("SELECT * FROM UserProducts WHERE date = '$today'");
        List<UserProduct> list =
            res.isNotEmpty ? res.map((c) => UserProduct.fromMap(c)).toList() : [];
        return list;
      }

    Future<List<DateAndCalory>> getAllProductsDateSplit() async {
        final db = await database;

        var result = List<DateAndCalory>();
        var res = await db.rawQuery("SELECT * FROM UserProducts");

        List<UserProduct> list =
          res.isNotEmpty ? res.map((c) => UserProduct.fromMap(c)).toList() : [];

        for (var i = 0; i < list.length; i++) {
          result.add(DateAndCalory(id: list[i].id,date: list[i].date,calory: list[i].calory));
        }

        return result;
      }
}