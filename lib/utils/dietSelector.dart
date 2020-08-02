import 'dart:convert';
import 'dart:math';

import 'package:calory_calc/models/dbModels.dart';

import 'doubleRounder.dart';

class DietParams {
  double calory;
  double squi;
  double fat;
  double carboh;

  DietParams({
    this.calory,
    this.squi,
    this.fat,
    this.carboh,
  });

  Map<String, dynamic> toMap() {
    return {
      'calory': calory,
      'squi': squi,
      'fat': fat,
      'carboh': carboh,
    };
  }

  static DietParams fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DietParams(
      calory: map['calory'],
      squi: map['squi'],
      fat: map['fat'],
      carboh: map['carboh'],
    );
  }

  String toJson() => json.encode(toMap());

  static DietParams fromJson(String source) => fromMap(json.decode(source));
}

DietParams selectDiet(User user) {
  var diet = DietParams();

  var squiPercent;
  var fatPercent;
  var carbohPercent;

  if (user.workFutureModel == 1) {
    fatPercent = 0.30;
    squiPercent = 0.30;
    carbohPercent = 0.40;
  } else if (user.workFutureModel == 2) {
    fatPercent = 0.35;
    squiPercent = 0.35;
    carbohPercent = 0.45;
  } else if (user.workFutureModel == 3) {
    fatPercent = 0.275;
    squiPercent = 0.325;
    carbohPercent = 0.50;
  }

  var genderDelta = user.gender ? 5 : -161.0;
  var caloryLimit = (10 * user.weight +
          6.25 * user.height -
          (4.92 * user.age) +
          genderDelta) *
      user.workModel;

  diet.calory = roundDouble(caloryLimit, 1);
  diet.squi = roundDouble(squiPercent * caloryLimit / 4, 1);
  diet.fat = roundDouble(fatPercent * caloryLimit / 9, 1);
  diet.carboh = roundDouble(carbohPercent * caloryLimit / 4, 1);

  return diet;
}
