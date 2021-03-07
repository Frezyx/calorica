import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/common/theme/theme.dart';
import 'package:calory_calc/utils/doubleRounder.dart';
import 'package:flutter/material.dart';

getStartText(
    todayParams, yesterdayParams, caloryLimitDeltaR, caloryLimitDeltaL) {
  var todayCalory = todayParams == null ? 0.0 : todayParams.calory;
  var yesterdayCalory = yesterdayParams == null ? 0.0 : yesterdayParams.calory;

  String text = "";
  bool bigCondition =
      todayCalory <= caloryLimitDeltaR && todayCalory >= caloryLimitDeltaL;
  TextStyle _style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 28,
    color: DesignTheme.blackTextColor,
  );

  if (todayCalory == 0.0) {
    text = "Вы ничего не ели сегодня";
    _style = DesignTheme.bigText2;
  } else if (todayCalory < yesterdayCalory && bigCondition) {
    text = "Лучше, чем вчера!";
  } else if (bigCondition) {
    text = "Сегодня вы - молодец!";
  } else if (todayCalory <= caloryLimitDeltaR && todayCalory > 1000) {
    text = "Сегодня можно ещё!";
  } else if (todayCalory <= caloryLimitDeltaR) {
    text = "Сегодня нужно съесть больше!";
    _style = DesignTheme.bigText2;
  } else if (todayCalory > caloryLimitDeltaR) {
    text = "Сегодня вы съели больше, чем нужно";
    _style = DesignTheme.bigText2;
  }

  return Text(
    text,
    style: _style,
  );
}

getParamText(
    todayParams, yesterdayParams, caloryLimitDeltaR, caloryLimitDeltaL) {
  var yesterdayCalory = yesterdayParams == null ? 0.0 : yesterdayParams.calory;
  var todayCalory = todayParams == null ? 0.0 : todayParams.calory;
  bool bigCondition =
      todayCalory <= caloryLimitDeltaR && todayCalory >= caloryLimitDeltaL;
  Color _color = DesignTheme.redColor;

  if (todayCalory == 0.0) {
    _color = DesignTheme.redColor;
  } else if (todayCalory < yesterdayCalory && bigCondition) {
    _color = CustomTheme.mainColor;
  } else if (bigCondition) {
    _color = CustomTheme.mainColor;
  } else if (todayCalory <= caloryLimitDeltaR && todayCalory > 1000) {
    _color = CustomTheme.mainColor;
  } else if (todayCalory <= caloryLimitDeltaR) {
    _color = DesignTheme.redColor;
  } else if (todayCalory > caloryLimitDeltaR) {
    _color = DesignTheme.redColor;
  }

  return Text(
    (todayCalory < yesterdayCalory)
        ? "-" + checkThousands((todayCalory - yesterdayCalory).abs()).toString()
        : "+" +
            checkThousands((todayCalory - yesterdayCalory).abs()).toString(),
    textAlign: TextAlign.start,
    style: TextStyle(
      fontSize: 38.0,
      fontWeight: FontWeight.w900,
      color: _color,
    ),
  );
}

checkThousands(double value) {
  if (value > 1000) {
    return roundDouble(value / 1000, 1).toString() + "К";
  }
  return value;
}

getOtherParamText(todayParam, yesterdayParam) {
  Color _color = DesignTheme.redColor;

  if (todayParam == 0.0 || todayParam > yesterdayParam) {
    _color = DesignTheme.redColor;
  } else {
    _color = CustomTheme.mainColor;
  }

  return Text(
    (todayParam < yesterdayParam)
        ? "-" + (roundDouble((todayParam - yesterdayParam), 1).abs()).toString()
        : "+" +
            (roundDouble((todayParam - yesterdayParam), 1).abs()).toString(),
    textAlign: TextAlign.start,
    style: TextStyle(
      fontSize: 38.0,
      fontWeight: FontWeight.w900,
      color: _color,
    ),
  );
}
