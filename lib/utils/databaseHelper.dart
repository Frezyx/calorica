import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:calory_calc/models/dbModels.dart';

import 'dateHalper.dart';

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

  Future<int>addUser(User user) async{
    final db = await database;
    var raw = await db.rawInsert(
        "INSERT Into Users (id, name, surname, weight, height, age, workModel, gender, workFutureModel, clickCount)"
        " VALUES (?,?,?,?,?,?,?,?,?,?)",
        [0, 
        user.name,
        user.surname,
        90.0,
        180.0,
        25.0,
        1.375,
        true,
        1,
        0
        ]);
    return raw;
  }
  
  Future<bool>counter() async{
    final db = await database;
    bool adResponse = false;
    var res = await db.rawQuery("SELECT * FROM Users");
    var item = res.first;
    int count = res.first['clickCount'];
    count++;
    if(count <= 20){
      updateDateProducts('clickCount', count);
    }
    else{
      adResponse = true;
      updateDateProducts('clickCount', 0);
    }
    return adResponse;
  }

  Future<int>updateDateProducts(String paramName, param) async{
    final db = await database;
    int count = await db.rawUpdate(
      "UPDATE Users SET $paramName = ? WHERE id = ?",
      ['$param', 0]);
    return count;
  }

  Future<int>updateUser(User user) async{
    final db = await database;
    int count = await db.rawUpdate(
      'UPDATE Users SET name = ?, surname = ?, weight = ?, height = ?, age = ?, workModel = ?, gender = ?, workFutureModel = ? WHERE id = ?',
      ['${user.name}' , '${user.surname}', '${user.weight}', '${user.height}', '${user.age}', '${user.workModel}', '${user.gender}', '${user.workFutureModel}', 0]);
    return count;
  }

  Future<User> getUser() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Users");
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

class DBProductProvider {
  DBProductProvider._();

  static final DBProductProvider db = DBProductProvider._();

  Database _database;
  var rng = new Random();
  Future<Database> get database async {
    if (_database != null) return _database;
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
    return(raw);
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
        var res = await db.query("Products", where: "name LIKE ?", whereArgs: ["%$text%"]);
        List<Product> list =
            res.isNotEmpty ? res.map((c) => Product.fromMap(c)).toList() : [];
        return list;
      }

      Future<List<Product>> getAllProducts() async {
        var rnd = Random();
        var offset = rnd.nextInt(7000);
        final db = await database;
        var res = await db.rawQuery("SELECT * FROM Products LIMIT 20 OFFSET '$offset'");
        List<Product> list =
            res.isNotEmpty ? res.map((c) => Product.fromMap(c)).toList() : [];
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
    _database = await initDB();
    return _database;
  }
  
  firstCreateTable() async{
    final db = await database;
    int id = 0;
    var now = getDateDayAgo(toStrDate(DateTime.now()));
    var raw = await db.rawInsert(
        "INSERT Into UserProducts (id, name, category, calory, squi, fat, carboh, date)"
        " VALUES (?,?,?,?,?,?,?,?)",
        [id,'Говядина отборная', 'Говядина и телятина', 0, 0.0, 0, 0, now]
        );
    return(raw);
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
          "date TEXT" 
          ")");
    });
  }

  toStrDate(DateTime date){
    return date.day.toString()+'.'+date.month.toString()+'.'+date.year.toString();
  }

  Future<DateAndCalory>addProduct(UserProduct product) async{
    final db = await database;
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM UserProducts");
    int id = table.first["id"];
    var now = DateTime.now();
    var strNow = toStrDate(now);

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
    return DateAndCalory(id:id,date:strNow);
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

  
  Future<List<UserProduct>> getTodayProducts() async{
    var now = toStrDate(DateTime.now());
    return await getProductsByDate(now);
  }

  Future<List<UserProduct>> getYesterdayProducts() async{
    var yesterday = getDateDayAgo(toStrDate(DateTime.now()));
    return await getProductsByDate(yesterday);
  }

  Future<List<UserProduct>> getProductsByDate(String date) async {
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

        var now = toStrDate(DateTime.now());
        var res = await db.rawQuery("SELECT * FROM UserProducts WHERE date = '$now'");
        List<UserProduct> list =
            res.isNotEmpty ? res.map((c) => UserProduct.fromMap(c)).toList() : [];
        return list;
      }

    Future<List<DateAndCalory>> getAllProductsDateSplit() async {
        final db = await database;

        var result = List<DateAndCalory>();
        var count = 0;
        var res = await db.rawQuery("SELECT * FROM UserProducts");

        List<UserProduct> list =
          res.isNotEmpty ? res.map((c) => UserProduct.fromMap(c)).toList() : [];

        for (var i = 0; i < list.length; i++) {
          result.add(DateAndCalory(id: list[i].id,date: list[i].date,calory: list[i].calory));
        }

        return result;
      }
}

class DateAndCalory {
  int id;
  String date;
  double calory;

  DateAndCalory({
    this.id,
    this.date,
    this.calory,
  });
  
}

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
          "date TEXT,"
          "ids TEXT"
          ")");
    });
  }

  Future<DateProducts>addDateProducts(DateProducts dateProducts) async{
    final db = await database;
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM DateProducts");
    int id = table.first["id"];
    var raw = await db.rawInsert(
        "INSERT Into DateProducts (id, date, ids)"
        " VALUES (?,?,?)",
        [id, 
        dateProducts.date,
        dateProducts.ids,
        ]);
    var respons = DateProducts(
      id: id,
      date: dateProducts.date,
      ids: dateProducts.ids,
    );
    return respons;
  }

  Future<List<int>> getPoductsIDsByDate(String date) async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM DateProducts WHERE date = '$date'");
    var item = res.first;
    var ids = item['ids'];
    var mass = ids.split(";");
    List<int> result = []; 
    for (var i = 0; i < mass.length; i++) {
      result.add(int.parse(mass[i]));
    }
    return result;
  }

  Future<DateProducts> getPoductsByDate(String date, int idToAdd) async {
    final db = await database;
    DateProducts respons;
    var res = await db.rawQuery("SELECT * FROM DateProducts WHERE date = '$date'");
    if(res.length == 0){
      var newDP = DateProducts(ids: idToAdd.toString(), date: toStrDate(DateTime.now()));
      addDateProducts(newDP).then((response){
        respons = DateProducts(id:response.id, ids: response.ids, date: response.date);
      });
    }
    else{
      var item = res.first;
      respons = DateProducts(id:item['id'], ids: item['ids'], date: item['date']);
    }
    return respons;
  }
  
  updateDateProducts(DateProducts products) async{
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


  toStrDate(DateTime date){
    return date.day.toString()+'.'+date.month.toString()+'.'+date.year.toString();
  }
}