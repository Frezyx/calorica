import 'package:flutter/material.dart';
import 'package:calory_calc/design/theme.dart';

class RangeGraphData{
  String name;
  double percent;
  LinearGradient gradient;
  double weigth;

  RangeGraphData({
    this.name,
    this.percent,
    this.gradient,
    this.weigth,
  });

}

getColor(RangeGraphData range){
  if (range.percent <= 30){
    range.gradient = LinearGradient(colors: [
            Colors.red[500],
            Colors.red[800],
          ]);
  }
  else if(range.percent <= 60){
    range.gradient = LinearGradient(colors: [
            Colors.yellow,
            Colors.yellow[800],
          ]);
  }
  else if(range.percent <= 100){
        range.gradient = LinearGradient(colors: [
            Colors.green,
            Colors.green[800],
          ]);
  }
  else{
    range.gradient = LinearGradient(colors: [
            Colors.red[500],
            Colors.red[800],
          ]);
  }
  return range;
}

