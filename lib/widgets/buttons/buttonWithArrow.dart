import 'package:calory_calc/design/theme.dart';
import 'package:flutter/material.dart';

class CustomButton {
  static getButtonArrowForward(
      String router, IconData icon, String buttonText, context) {
    return FlatButton(
      color: Colors.transparent,
      padding: EdgeInsets.all(0.0),
      splashColor: DesignTheme.mainColor,
      focusColor: DesignTheme.mainColor,
      highlightColor: Colors.white,
      hoverColor: Colors.white,
      onPressed: () {
        Navigator.popAndPushNamed(context, router);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            color: DesignTheme.mainColor,
          ),
          Text(buttonText,
              style: TextStyle(
                color: DesignTheme.mainColor,
              ))
        ],
      ),
    );
  }
}
