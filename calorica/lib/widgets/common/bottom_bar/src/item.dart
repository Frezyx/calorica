import 'package:flutter/material.dart';

class BottomBarItem extends StatelessWidget {
  final IconData iconData;
  final bool isSelected;
  final Function() onTap;

  const BottomBarItem({
    Key key,
    @required this.iconData,
    this.isSelected = false,
    @required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 70,
        child: Icon(
          iconData,
          size: 28,
          color: isSelected ? theme.primaryColor : theme.hintColor,
        ),
      ),
    );
  }
}
