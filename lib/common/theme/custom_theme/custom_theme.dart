import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
abstract class CustomTheme {
  static Color get mainColorSimple => Color(0xFF51D684);
  static MaterialColor get mainColor => MaterialColor(
        mainColorSimple.value,
        _mainColorCodes,
      );

  static Color get lightColor => Colors.white;
  static Color get darkColor => Colors.black;

  static Color get hintColor => Colors.grey[500];

  static Color get backgroundColor => Color.fromRGBO(244, 244, 244, 1);
  static Color get lightScaffoldBackgroundColor => Color(0xFFFAFAFA);

  static TextStyle get inputLabel => TextStyle(
        fontSize: 16,
        color: CustomTheme.darkColor,
      );

  static TextStyle get title => TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get subtitle => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      );

  static get lightFormShadow => [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          blurRadius: 5,
          offset: const Offset(0, 2),
        ),
      ];

  static get authInputDecoration => InputDecoration(
        labelStyle: CustomTheme.inputLabel,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: CustomTheme.mainColor,
            style: BorderStyle.solid,
          ),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: CustomTheme.mainColor,
            style: BorderStyle.solid,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
            color: CustomTheme.mainColor,
          ),
        ),
        contentPadding: EdgeInsets.only(bottom: 0.0, left: 5.0, right: 5.0),
      );

  static final Map<int, Color> _mainColorCodes = {
    50: CustomTheme.mainColorSimple.withOpacity(.1),
    100: CustomTheme.mainColorSimple.withOpacity(.2),
    200: CustomTheme.mainColorSimple.withOpacity(.3),
    300: CustomTheme.mainColorSimple.withOpacity(.4),
    400: CustomTheme.mainColorSimple.withOpacity(.5),
    500: CustomTheme.mainColorSimple.withOpacity(.6),
    600: CustomTheme.mainColorSimple.withOpacity(.7),
    700: CustomTheme.mainColorSimple.withOpacity(.8),
    800: CustomTheme.mainColorSimple.withOpacity(.9),
    900: CustomTheme.mainColorSimple,
  };

  static EdgeInsets get pagePadding => EdgeInsets.only(top: 40.0);
}
