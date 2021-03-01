import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
abstract class CustomTheme {
  static const Color mainColorSimple = Color(0xFF51D684);
  static final MaterialColor mainColor = MaterialColor(
    mainColorSimple.value,
    _mainColorCodes,
  );

  static final Color lightColor = Colors.white;
  static final Color darkColor = Colors.black;

  static const Color bgColor = Color.fromRGBO(244, 244, 244, 1);

  static const Color lightScaffoldBackgroundColor = Color(0xFFE9E9E9);

  static final lightFormShadow = [
    BoxShadow(
      color: Colors.grey.withOpacity(0.1),
      blurRadius: 5,
      offset: const Offset(0, 2),
    ),
  ];

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

  static const EdgeInsets pagePadding = EdgeInsets.only(top: 40.0);
}
