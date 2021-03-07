import 'package:calory_calc/design/theme.dart';
import 'package:flutter/material.dart';

class ToolBarIconButton extends StatelessWidget {
  const ToolBarIconButton({
    Key key,
    @required this.onTap,
    @required this.icon,
  }) : super(key: key);

  final Function() onTap;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: DesignTheme.shadowByOpacity(0.03),
        ),
        child: Center(
          child: icon,
        ),
      ),
    );
  }
}
