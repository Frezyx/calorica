import 'dart:math';

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
  var rng = new Random();
  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }
  
  firstCreateTable() async{
    final db = await database;
    int id = 0;
    var raw = await db.rawInsert(
        "INSERT Into Products (id, name, category, calory, squi, fat, carboh)"
        " VALUES (?,?,?,?,?,?,?)",
        [id,'Говядина отборная', 'Говядина и телятина', 218, 18.6, 16, 0]
        );
    print("Первая запись");
    return(raw);
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Products.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          print("БД создана");
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

  Future<int>addProduct(Product product) async{
    final db = await database;
    // var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Products");
    // int id = table.first["id"];
    int id =rng.nextInt(100)*rng.nextInt(100)+rng.nextInt(100)*rng.nextInt(100)*rng.nextInt(1200);
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
      print(id.toString() + product.name + product.category + product.carboh.toString());
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
        // date: DateTime.fromMillisecondsSinceEpoch(item["date"]),
      );

    return product;
  }

      Future<List<Product>> getAllProductsSearch(String text) async {
        print(1);
        final db = await database;
        var res = await db.query("Products", where: "name LIKE ?", whereArgs: ["%$text%"]);
        List<Product> list =
            res.isNotEmpty ? res.map((c) => Product.fromMap(c)).toList() : [];
        //     for (int i = 0; i <list.length; i++){
        //       print(i.toString() + list[i].name.toString());
        //     }
        // print(list.length.toString() + "Кол-во ссаных заметок");
        return list;
      }

      Future<List<Product>> getAllProducts() async {
        // print("Я зашёл в поиск");
        final db = await database;
        var res = await db.rawQuery("SELECT * FROM Products LIMIT 10 OFFSET 0");
        List<Product> list =
            res.isNotEmpty ? res.map((c) => Product.fromMap(c)).toList() : [];
        //     for (int i = 0; i <list.length; i++){
        //       // print(i.toString() + list[i].name.toString());
        //     }
        // print(list.length.toString() + "Кол-во ссаных заметок");
        return list;
      }

}

class DBUserProductsProvider {
  DBUserProductsProvider._();

  static final DBUserProductsProvider db = DBUserProductsProvider._();

  Database _database;
  var rng = new Random();
  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }
  
  firstCreateTable() async{
    final db = await database;
    int id = 0;
    var now = toStrDate(DateTime.now());
    var raw = await db.rawInsert(
        "INSERT Into UserProducts (id, name, category, calory, squi, fat, carboh, date)"
        " VALUES (?,?,?,?,?,?,?,?)",
        [id,'Говядина отборная', 'Говядина и телятина', 218, 18.6, 16, 0, now]
        );
    print("Первая запись");
    return(raw);
  }


  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "UserProducts.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          print("БД создана");
      await db.execute("CREATE TABLE UserProducts ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "category TEXT,"
          "calory DOUBLE,"
          "squi DOUBLE,"
          "fat DOUBLE,"
          "carboh DOUBLE,"
          "date TEXT" 
          ")");
    });
  }

  toStrDate(DateTime date){
    return date.day.toString()+'.'+date.month.toString()+'.'+date.year.toString();
  }

  Future<int>addProduct(UserProduct product) async{
    final db = await database;
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM UserProducts");
    int id = table.first["id"];
    var now = DateTime.now();
    var strNow = toStrDate(now);
    // int id =rng.nextInt(100)*rng.nextInt(100)+rng.nextInt(100)*rng.nextInt(100)*rng.nextInt(1200);
    var raw = await db.rawInsert(
        "INSERT Into UserProducts (id, name, category, calory, squi, fat, carboh, date)"
        " VALUES (?,?,?,?,?,?,?,?)",
        [id, 
        product.name,
        product.category,
        product.calory,
        product.squi,
        product.fat,
        product.carboh,
        strNow,
        ]);
        print(raw);
      print(strNow);
    return id;
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
        date: item["date"],
      );

    return product;
  }

  deleteAll() async {
    final db = await database;
    db.rawQuery("DELETE FROM UserProducts");
  }
      Future<List<UserProduct>> getAllProducts() async {
        final db = await database;

        var now = toStrDate(DateTime.now());
        var res = await db.rawQuery("SELECT * FROM UserProducts WHERE date = '$now'");
        List<UserProduct> list =
            res.isNotEmpty ? res.map((c) => UserProduct.fromMap(c)).toList() : [];
              // for (int i = 0; i <list.length; i++){
              //   if(list[i].date == now){

              //   }
              //   // print("Дата из БД " + list[i].date.toString() + " Дата сейчас " + now.toString());
              // }
        return list;
      }

}