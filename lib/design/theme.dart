import 'package:calory_calc/common/theme/theme.dart';
import 'package:flutter/material.dart';

class DesignTheme {
  DesignTheme._();

  static const String fontMain = 'Montserrat';

  static const Color backgroundColor = Color.fromRGBO(244, 244, 244, 1);
  static const Color whiteColor = Color.fromRGBO(255, 255, 255, 1);

  static const Color secondColor = Color.fromRGBO(86, 211, 113, 1);
  static const Color mainColor = Color.fromRGBO(68, 211, 177, 1);

  static const Color blackTextColor = Color(0xFF17262A);
  static const Color blackLightTextColor = Color(0xFF092043);
  static const Color gray36Color = Color.fromRGBO(36, 36, 36, 1);
  static const Color gray50Color = Color.fromRGBO(50, 50, 50, 1);
  static const Color gray170Color = Color.fromRGBO(170, 170, 170, 1);

  static const Color redColor = Color.fromRGBO(220, 92, 92, 1);

  static const Color secondChartsGreen = Color.fromRGBO(162, 229, 184, 1);
  static const Color secondChartRed = Color.fromRGBO(229, 162, 162, 1);

  static const Color selectorGrayText = Color.fromRGBO(103, 103, 103, 1);
  static const Color selectorGrayBackGround = Color.fromRGBO(234, 234, 234, 1);
  static const Color selectorGray1 = Color.fromRGBO(180, 180, 180, 1);
  static const Color selectorGray2 = Color.fromRGBO(132, 132, 132, 1);
  static const Color selectorGray3 = Color.fromRGBO(72, 72, 72, 1);

  static const Color darkBlue = Color.fromRGBO(29, 23, 48, 1);

  static const TextStyle selectorBigText = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w500,
    fontSize: 20,
    color: selectorGray3,
  );

  static const TextStyle selectorBigTextAction = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    fontSize: 20,
    color: mainColor,
  );

  static const TextStyle selectorLabel = TextStyle(
    fontFamily: fontMain,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: selectorGrayText,
  );

  static const TextStyle selectorMiniLabel = TextStyle(
    fontFamily: fontMain,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: selectorGrayText,
  );

  static const TextStyle bigText = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.bold,
    fontSize: 36,
    color: blackTextColor,
  );

  static const TextStyle bigText1 = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.bold,
    fontSize: 36,
    color: blackTextColor,
  );

  static const TextStyle bigText2 = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.bold,
    fontSize: 30,
    color: blackTextColor,
  );

  static const TextStyle bigText3 = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.bold,
    fontSize: 24,
    color: blackTextColor,
  );

  static const TextStyle bigErrorText = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.bold,
    fontSize: 18,
    color: blackTextColor,
  );

  static const TextStyle lilErrorText = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: gray50Color,
  );

  static const TextStyle blackText = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.bold,
    fontSize: 44,
    color: blackTextColor,
  );

  static const TextStyle bigText24 = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.bold,
    fontSize: 24,
    color: blackTextColor,
  );

  static const TextStyle bigText20 = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: blackTextColor,
  );

  static const TextStyle bigMainText = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.bold,
    fontSize: 36,
    color: mainColor,
  );

  static const TextStyle midleMainText = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: mainColor,
  );

  static const TextStyle midleMainTextBig = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.bold,
    fontSize: 24,
    color: mainColor,
  );

  static const TextStyle bigWhiteText = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    fontSize: 36,
    color: whiteColor,
  );

  static const TextStyle buttonText = TextStyle(
    fontFamily: fontMain,
    fontWeight: FontWeight.w700,
    fontSize: 16,
    color: whiteColor,
  );

  static const TextStyle label = TextStyle(
    fontFamily: fontMain,
    fontWeight: FontWeight.w400,
    fontSize: 20,
    color: blackTextColor,
  );

  static const TextStyle lilWhiteText = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: -0.2,
    color: DesignTheme.whiteColor,
  );

  static const TextStyle secondaryText = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: -0.2,
    color: DesignTheme.gray170Color,
  );

  static const TextStyle secondaryTextBig = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.2,
    color: DesignTheme.gray170Color,
  );

  static const TextStyle primeText = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 18,
    letterSpacing: -0.2,
    color: DesignTheme.gray36Color,
  );

  static const TextStyle primeTextBig = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 20,
    letterSpacing: -0.2,
    color: DesignTheme.gray36Color,
  );

  static const TextStyle primeText16 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.3,
    color: DesignTheme.gray36Color,
  );

  static const TextStyle lilGrayText = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: Colors.black54,
  );

  static TextStyle get inputText => TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: CustomTheme.mainColor,
      );

  static const TextStyle labelSearchText = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 16,
    letterSpacing: 0.2,
    color: Colors.black54,
  );

  static const TextStyle labelSearchTextBig = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 18,
    letterSpacing: 0.2,
    color: Colors.black54,
  );

  static const TextStyle labelSearchTextBigger = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 20,
    letterSpacing: 0.2,
    color: gray170Color,
  );

  static const TextStyle labelTextBiggerBlack = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 20,
    letterSpacing: 0.2,
    color: blackTextColor,
  );

  static get gradient => LinearGradient(
        colors: [CustomTheme.mainColor, CustomTheme.mainColor],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        stops: [0.0, 1.0],
        tileMode: TileMode.clamp,
      );

  static BoxShadow get selectorShadow => BoxShadow(
        color: CustomTheme.mainColor,
        blurRadius: 8.0,
        spreadRadius: 2.0,
        offset: Offset(
          0.0,
          4.0,
        ),
      );

  static const BoxShadow transperentShadow = BoxShadow(
    color: Colors.transparent,
    blurRadius: 15.0,
    spreadRadius: 2.0,
    offset: Offset(
      10.0,
      10.0,
    ),
  );

  static shadowByOpacity(double opacity) {
    return [
      BoxShadow(
        color: Colors.black12.withOpacity(opacity),
        blurRadius: 5.0,
        spreadRadius: 2.0,
        offset: Offset(
          0.0,
          5.0,
        ),
      )
    ];
  }

  static const BoxShadow originalShadow = BoxShadow(
    color: Colors.black12,
    blurRadius: 20.0,
    spreadRadius: 2.0,
    offset: Offset(
      10.0,
      10.0,
    ),
  );

  static const BoxShadow originalShadowLil = BoxShadow(
    color: Colors.black12,
    blurRadius: 14.0,
    spreadRadius: 2.0,
    offset: Offset(
      0.0,
      4.0,
    ),
  );
}
