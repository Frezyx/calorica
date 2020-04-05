import 'package:flutter/material.dart';
import 'package:calory_calc/design/theme.dart';

class RangeGraphData{
  double limit;
  String name;
  double percent;
  LinearGradient gradient;
  double weigth;

  RangeGraphData({
    this.name,
    this.percent,
    this.gradient,
    this.weigth,
    this.limit,
  });

}

getColor(double percent){
  if (percent <= 30){
    return LinearGradient(colors: [
            Colors.red[500],
            Colors.red[800],
          ]);
  }
  else if(percent <= 60){
    return LinearGradient(colors: [
            Colors.yellow,
            Colors.yellow[800],
          ]);
  }
  else if(percent <= 100){
        return LinearGradient(colors: [
            Colors.green,
            Colors.green[800],
          ]);
  }
  else{
    return LinearGradient(colors: [
            Colors.red[500],
            Colors.red[800],
          ]);
  }
}

