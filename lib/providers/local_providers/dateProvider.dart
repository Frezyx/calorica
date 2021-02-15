import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:calory_calc/models/dbModels.dart';
import 'package:calory_calc/utils/dateHelpers/dateFromInt.dart';

class DBDateProductsProvider {
  DBDateProductsProvider._();

  static final DBDateProductsProvider db = DBDateProductsProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "DateProducts.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE DateProducts ("
          "id INTEGER PRIMARY KEY,"
          "date INTEGER,"
          "ids TEXT"
          ")");
    });
  }

  Future<DateProducts> addDateProducts(DateProducts dateProducts) async {
    final db = await database;

    dateProducts.date = DateTime(
        dateProducts.date.year, dateProducts.date.month, dateProducts.date.day);
    var intDate = epochFromDate(dateProducts.date);

    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM DateProducts");
    int id = table.first["id"];

    var raw = await db.rawInsert(
        "INSERT Into DateProducts (id, date, ids)"
        " VALUES (?,?,?)",
        [
          id,
          intDate,
          dateProducts.ids,
        ]);

    var respons = DateProducts(
      id: id,
      date: dateProducts.date,
      ids: dateProducts.ids,
    );

    return respons;
  }

  Future<List<int>> getPoductsIDsByDate(DateTime date) async {
    final db = await database;

    var dateByYMD = DateTime(date.year, date.month, date.day);
    var dateInt = epochFromDate(dateByYMD);

    var res =
        await db.rawQuery("SELECT * FROM DateProducts WHERE date = '$dateInt'");

    var item = res.first;
    var ids = item['ids'];
    var mass = ids.split(";");
    List<int> result = [];
    for (var i = 0; i < mass.length; i++) {
      result.add(int.parse(mass[i]));
    }
    return result;
  }

//TODO: ??
  Future<bool> getPoductsByDate(DateTime date, int idToAdd) async {
    final db = await database;

    var dateByYMD = DateTime(date.year, date.month, date.day);
    var dateInt = epochFromDate(dateByYMD);

    bool resp = false;
    var res =
        await db.rawQuery("SELECT * FROM DateProducts WHERE date = '$dateInt'");

    if (res.length == 0) {
      var newDP = DateProducts(ids: idToAdd.toString(), date: dateByYMD);
      var response = await addDateProducts(newDP);
      resp = response != null;
    } else {
      var item = res.first;
      var products = DateProducts(
          id: item['id'],
          ids: item['ids'],
          date: DateTime.fromMillisecondsSinceEpoch(item['date']));
      try {
        products.ids += ";" + res.first['id'].toString();
      } catch (e) {}
      var response =
          await DBDateProductsProvider.db.updateDateProducts(products);
      resp = response == 1;
    }
    return resp;
  }

  updateDateProducts(DateProducts products) async {
    final db = await database;

    int count = await db.rawUpdate(
        'UPDATE DateProducts SET ids = ? WHERE id = ?',
        ['${products.ids}', '${products.id}']);
  }

  Future<List<DateProducts>> getDates() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM DateProducts");

    List<DateProducts> list =
        res.isNotEmpty ? res.map((c) => DateProducts.fromMap(c)).toList() : [];
    return list;
  }
}
