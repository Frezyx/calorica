import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    Key key,
    @required this.child,
    @required this.onPressed,
    this.height = 48.0,
    this.width = double.infinity,
    this.highlightColor,
    this.color,
    this.borderRadius,
  }) : super(key: key);

  final Widget child;
  final Color color;
  final double width;
  final double height;
  final Color highlightColor;
  final Function() onPressed;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: RaisedButton(
        color: color,
        highlightColor: highlightColor ?? color,
        elevation: 0.0,
        onPressed: onPressed,
        child: child,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
