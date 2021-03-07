import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/common/theme/theme.dart';
import 'package:calory_calc/utils/adClickHelper.dart';
import 'package:flutter/material.dart';

getArrowBackAppBar(title, route, context) {
  return AppBar(
    leading: IconButton(
        onPressed: () {
          Navigator.popAndPushNamed(context, route);
        },
        icon: Icon(
          Icons.arrow_back,
          size: 24,
        )),
    elevation: 5.0,
    backgroundColor: DesignTheme.whiteColor,
    title: Text(
      title,
      style: TextStyle(fontWeight: FontWeight.w700),
    ),
  );
}
