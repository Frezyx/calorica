import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  const CustomRaisedButton({
    Key key,
    this.width = double.infinity,
    this.height = 50,
    this.color,
    this.highlightColor,
    @required this.onPressed,
    this.borderRadius,
    @required this.child,
  }) : super(key: key);

  final double width;
  final double height;
  final Color color;
  final Color highlightColor;
  final Function() onPressed;
  final Widget child;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
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
