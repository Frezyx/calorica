import 'package:calory_calc/design/theme.dart';

import 'package:flutter/material.dart';

getOtherParamTextColumn(todayParam, yesterdayParam, String text, Widget value) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          value,
          Text(
            text,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: DesignTheme.gray170Color),
          ),
        ],
      ),
    ],
  );
}
