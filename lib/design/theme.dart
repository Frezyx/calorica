import 'package:flutter/material.dart';


class DesignTheme {
  DesignTheme._();

  static const String fontMain = 'Montserrat';
  static const Color bgColor = Color.fromRGBO(244, 244, 244, 1);
  static const Color whiteColor = Color.fromRGBO(255, 255, 255, 1);
  static const Color secondColor = Color.fromRGBO(86, 211, 113, 1);
  static const Color mainColor = Color.fromRGBO(68, 211, 177, 1);
  static const Color blackColor = Color.fromRGBO(0, 0, 0, 1);
  static const Color gray36Color = Color.fromRGBO(36, 36, 36, 1);
  static const Color gray50Color = Color.fromRGBO(50, 50, 50, 1);
  static const Color gray170Color = Color.fromRGBO(170, 170, 170, 1);

  static const TextStyle bigText = TextStyle( // h5 -> headline
    fontFamily:
    'Montserrat',
    fontWeight: FontWeight.bold,
    fontSize: 36,
    color: blackColor,
  );

  static const TextStyle bigText24 = TextStyle( // h5 -> headline
    fontFamily:
    'Montserrat',
    fontWeight: FontWeight.bold,
    fontSize: 24,
    color: blackColor,
  );

  static const TextStyle bigText20 = TextStyle( // h5 -> headline
    fontFamily:
    'Montserrat',
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: blackColor,
  );

  static const TextStyle bigMainText = TextStyle( // h5 -> headline
    fontFamily:
    'Montserrat',
    fontWeight: FontWeight.bold,
    fontSize: 36,
    color: mainColor,
  );

  static const TextStyle bigWhiteText = TextStyle( // h5 -> headline
    fontFamily:
    'Montserrat',
    fontWeight: FontWeight.w600,
    fontSize: 36,
    color: whiteColor,
  );

  static const TextStyle buttonText = TextStyle( // h5 -> headline
    fontFamily: fontMain,
    fontWeight: FontWeight.w800,
    fontSize: 22,
    color: whiteColor,
  );

  static const TextStyle label = TextStyle( // h5 -> headline
    fontFamily: fontMain,
    fontWeight: FontWeight.w400,
    fontSize: 20,
    color: blackColor,
  );

  static const TextStyle lilWhiteText = TextStyle( // h5 -> headline
      fontWeight: FontWeight.w500,
      fontSize: 16,
      letterSpacing: -0.2,
      color: DesignTheme.whiteColor,
  );

  static const TextStyle secondaryText = TextStyle( // h5 -> headline
      fontWeight: FontWeight.w400,
      fontSize: 12,
      letterSpacing: -0.2,
      color: DesignTheme.gray170Color,
  );

  static const TextStyle primeText = TextStyle( // h5 -> headline
      fontWeight: FontWeight.w400,
      fontSize: 18,
      letterSpacing: -0.2,
      color: DesignTheme.gray36Color,
  );

  static const TextStyle lilGrayText = TextStyle( // h5 -> headline
      fontWeight: FontWeight.w400,
      fontSize: 14,
      letterSpacing: 0.2,
      color: Colors.black54,
  );

  static const TextStyle inputText = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: DesignTheme.mainColor,
  );

  static const TextStyle labelSearchText = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 16,
    letterSpacing: 0.2,
    color: Colors.black54,
  );

  static const TextStyle labelSearchTextBigger = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 20,
    letterSpacing: 0.2,
    color: gray170Color,
  );

  static const LinearGradient 
    gradient = LinearGradient(
      colors: [
        DesignTheme.secondColor,
        DesignTheme.mainColor
      ],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      stops: [0.0,1.0],
      tileMode: TileMode.clamp
    );
  }