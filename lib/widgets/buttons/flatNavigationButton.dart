import 'package:calory_calc/design/theme.dart';
import 'package:flutter/material.dart';

getFlatNavigationButton(title, route, context) {
  return InkWell(
    splashColor: DesignTheme.mainColor,
    child: Row(children: <Widget>[
      Padding(
        padding: EdgeInsets.only(
          right: 5,
        ),
        child: Text(
          title,
          style: DesignTheme.labelTextBiggerBlack,
        ),
      ),
      Icon(Icons.chevron_right, color: DesignTheme.mainColor),
    ]),
    onTap: () {
      Navigator.pushNamed(context, route);
    },
  );
}
