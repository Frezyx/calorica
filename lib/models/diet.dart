import 'dart:convert';

import 'package:calory_calc/utils/dateHelpers/dateFromInt.dart';

class Diet {
  int id;
  String name;
  int user_id;
  double calory;
  double squi;
  double fat;
  double carboh;
  DateTime date;

  Diet({
    this.id,
    this.name,
    this.user_id,
    this.calory,
    this.squi,
    this.fat,
    this.carboh,
    this.date,
  });
  

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'user_id': user_id,
      'calory': calory,
      'squi': squi,
      'fat': fat,
      'carboh': carboh,
      'date': epochFromDate(date),
    };
  }

  static Diet fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Diet(
      id: map['id'],
      name: map['name'],
      user_id: map['user_id'],
      calory: map['calory'],
      squi: map['squi'],
      fat: map['fat'],
      carboh: map['carboh'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  static Diet fromJson(String source) => fromMap(json.decode(source));
}
