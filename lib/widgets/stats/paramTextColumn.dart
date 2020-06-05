import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/widgets/textHelper.dart';
import 'package:flutter/material.dart';

getOtherParamTextColumn(todayParam, yesterdayParam, text){
  return           Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:<Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 5, top: 10, left: 30, right: 20),
                child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children:<Widget>[
                    getOtherParamText(todayParam, yesterdayParam),
                    Text(text,
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.w600, color: DesignTheme.gray170Color),
                    ),
                ])
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 10, top: 0, left: 45, right: 20),
                child:
                  Text('По сравнению с вчерашним днём',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w400, color: DesignTheme.gray50Color),
                  ),
              ),
            ]);
}