import 'package:calory_calc/design/theme.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

getMainGradientButton(String text, String route, context) {
  return GradientButton(
    increaseWidthBy: 40,
    increaseHeightBy: 8,
    child: Padding(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: DesignTheme.buttonText,
      ),
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
    ),
    callback: () {
      route == "pop"
          ? Navigator.pop(context)
          : Navigator.popAndPushNamed(context, route);
    },
    shapeRadius: BorderRadius.circular(50.0),
    gradient: DesignTheme.gradient,
    shadowColor: Gradients.backToFuture.colors.last.withOpacity(0.25),
  );
}
