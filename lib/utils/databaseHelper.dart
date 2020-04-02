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

class DBProductProvider {
  DBProductProvider._();

  static final DBProductProvider db = DBProductProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
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
          "calory TEXT,"
          "squi TEXT,"
          "fat TEXT,"
          "carboh TEXT,"
          "date TEXT"
          ")");
    });
  }

  Future<int>addProduct(Product product) async{
    final db = await database;
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Products");
    int id = table.first["id"];
    var raw = await db.rawInsert(
        "INSERT Into Products (id, name, category, calory, squi, fat, carboh)"
        " VALUES (?,?,?,?,?,?,?)",
        [id, 
        product.name,
        product.category,
        product.calory,
        product.squi,
        product.fat,
        product.carboh,
        // product.date,
        ]);
      print(raw);
    return raw;
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
        // date: DateTime.fromMillisecondsSinceEpoch(item["date"]),
      );

    return product;
  }

      Future<List<Product>> getAllProductsSearch(String text) async {
        final db = await database;
        var res = await db.query("Products", where: "name LIKE ?", whereArgs: [0, "%$text%"], orderBy: "calory DESC");
        List<Product> list =
            res.isNotEmpty ? res.map((c) => Product.fromMap(c)).toList() : [];
            for (int i = 0; i <list.length; i++){
              // print(i.toString() + list[i].is_archived.toString());
            }
        print(list.length.toString() + "Кол-во ссаных заметок");
        return list;
      }

}