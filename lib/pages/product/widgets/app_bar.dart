import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/common/theme/theme.dart';
import 'package:flutter/material.dart';

class ProductsListAppBar extends StatelessWidget {
  const ProductsListAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      child: Text(
        "Добавление \nприема пищи",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 28,
          color: DesignTheme.blackTextColor,
        ),
      ),
    );
  }
}
