import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/common/theme/theme.dart';
import 'package:flutter/material.dart';

class ProductParamPanel extends StatelessWidget {
  const ProductParamPanel({
    Key key,
    @required this.title,
    @required this.value,
  }) : super(key: key);

  final String title;
  final double value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.44,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: DesignTheme.shadowByOpacity(0.03),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            value.toString(),
            style: DesignTheme.bigMainText,
          ),
          Text(
            title,
            style: DesignTheme.labelSearchText,
          ),
        ],
      ),
    );
  }
}
