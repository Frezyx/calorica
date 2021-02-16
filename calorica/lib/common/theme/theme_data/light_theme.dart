import 'package:flutter/material.dart';
import 'package:calorica/common/theme/custom_theme.dart';

ThemeData get lightTheme => ThemeData(
      cardColor: Colors.white,
      hintColor: Colors.grey,
      primaryColor: CustomTheme.mainColor,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: CustomTheme.mainColor,
        accentColor: CustomTheme.mainColor,
      ),
    );
