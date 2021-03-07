import 'package:calory_calc/utils/calculator_parts/percent_checker.dart';
import 'package:flutter/material.dart';

class RangeGraphData {
  double limit;
  String name;
  double percent;
  double weigth;

  RangeGraphData({
    this.name,
    this.percent,
    this.weigth,
    this.limit,
  });

  final percentChecker = PercentChecker(
    firstLimit: 30,
    middleLimit: 60,
    finalLimit: 100,
  );

  LinearGradient get gradient {
    var _gradient = LinearGradient(colors: [
      Colors.red[500],
      Colors.red[800],
    ]);

    percentChecker.inRange(
      percent,
      onFirstPart: () {},
      onMiddlePart: () {
        _gradient = LinearGradient(colors: [
          Colors.yellow[500],
          Colors.yellow[800],
        ]);
      },
      onFinalPart: () {
        _gradient = LinearGradient(colors: [
          Colors.green,
          Colors.green[800],
        ]);
      },
    );
    return _gradient;
  }

  Color get color {
    var color = Colors.red[800];
    percentChecker.inRange(
      percent,
      onFirstPart: () {},
      onMiddlePart: () {
        color = Colors.yellow[800];
      },
      onFinalPart: () {
        color = Colors.green[800];
      },
    );
    return color;
  }
}
