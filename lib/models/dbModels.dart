import 'dart:convert';

import 'package:calory_calc/common/utils/dateHelpers/dateFromInt.dart';

class User {
  int id;
  String name;
  String surname;
  double weight;
  double height;
  double age;
  double workModel;
  bool gender;
  int workFutureModel;
  int clickCount;

  User({
    this.id,
    this.name,
    this.surname,
    this.weight,
    this.height,
    this.age,
    this.workModel,
    this.gender,
    this.workFutureModel,
    this.clickCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'weight': weight,
      'height': height,
      'age': age,
      'workModel': workModel,
      'gender': gender == 1,
      'workFutureModel': workFutureModel,
      'clickCount': clickCount,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      id: map['id'],
      name: map['name'],
      surname: map['surname'],
      weight: map['weight'],
      height: map['height'],
      age: map['age'],
      workModel: map['workModel'],
      gender: map['gender'],
      workFutureModel: map['workFutureModel'],
      clickCount: map['clickCount'],
    );
  }

  String toJson() => json.encode(toMap());

  static User fromJson(String source) => fromMap(json.decode(source));
}

class Product {
  int id;
  String name;
  String category;
  double calory;
  double squi;
  double fat;
  double carboh;

  Product({
    this.id,
    this.name,
    this.category,
    this.calory,
    this.squi,
    this.fat,
    this.carboh,
  });

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        calory: json["calory"],
        squi: json["squi"],
        fat: json["fat"],
        carboh: json["carboh"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "category": category,
        "calory": calory,
        "squi": squi,
        "fat": fat,
        "carboh": carboh,
      };
}

class UserProduct {
  int id;
  String name;
  String category;
  double calory;
  double squi;
  double fat;
  double carboh;
  DateTime date;
  double grams;
  int productId;

  UserProduct({
    this.id,
    this.name,
    this.category,
    this.calory,
    this.squi,
    this.fat,
    this.carboh,
    this.date,
    this.grams,
    this.productId,
  });

  factory UserProduct.fromMap(Map<String, dynamic> json) => UserProduct(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        calory: json["calory"],
        squi: json["squi"],
        fat: json["fat"],
        carboh: json["carboh"],
        date: DateTime.fromMillisecondsSinceEpoch(json["date"]),
        grams: json['grams'],
        productId: json["productId"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "category": category,
        "calory": calory,
        "squi": squi,
        "fat": fat,
        "carboh": carboh,
        "date": epochFromDate(date),
        "grams": grams,
        "productId": productId,
      };
}

class DateProducts {
  String ids;
  DateTime date;
  int id;

  DateProducts({
    this.date,
    this.id,
    this.ids,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': epochFromDate(date),
      'id': id,
      'ids': ids,
    };
  }

  static DateProducts fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DateProducts(
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      id: map['id'],
      ids: map['ids'],
    );
  }

  String toJson() => json.encode(toMap());

  static DateProducts fromJson(String source) => fromMap(json.decode(source));
}
