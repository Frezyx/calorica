import 'package:calory_calc/common/theme/theme.dart';
import 'package:flutter/material.dart';

ThemeData get lightTheme => ThemeData(
      fontFamily: 'Montserrat',
      cardColor: Colors.white,
      hintColor: Colors.grey[400],
      backgroundColor: CustomTheme.bgColor,
      scaffoldBackgroundColor: CustomTheme.lightScaffoldBackgroundColor,
      primaryColor: CustomTheme.mainColor,
      accentColor: CustomTheme.mainColor,
      dividerColor: Colors.grey.withOpacity(0.5),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: CustomTheme.mainColor,
        accentColor: CustomTheme.mainColor,
      ),
      buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.primary,
        buttonColor: CustomTheme.mainColor,
      ),
      textTheme: TextTheme(
        button: TextStyle(
          color: Colors.white,
        ),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.light,
    );
