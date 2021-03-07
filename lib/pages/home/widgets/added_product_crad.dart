import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/models/dbModels.dart';
import 'package:flutter/material.dart';

class AddedProductCard extends StatelessWidget {
  const AddedProductCard({
    Key key,
    this.product,
  }) : super(key: key);

  final UserProduct product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: DesignTheme.shadowByOpacity(0.02),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                product.name,
                style: DesignTheme.primeText,
              ),
              Text(
                product.calory.toString() + " кКал  ",
                style: DesignTheme.secondaryText,
              )
            ]),
      ),
      onTap: () {
        Navigator.popAndPushNamed(context, '/navigator/2');
      },
    );
  }
}
