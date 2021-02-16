import 'package:flutter/material.dart';

abstract class CustomTheme {
  static Color mainColorSimple = Color(0xFF51DF70);
  static MaterialColor mainColor = MaterialColor(0xFF51DF70, _mainColorCodes);

  static Map<int, Color> _mainColorCodes = {
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
}
