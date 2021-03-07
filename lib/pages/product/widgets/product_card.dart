import 'package:calory_calc/design/theme.dart';

import 'package:flutter/material.dart';

import 'package:calory_calc/models/dbModels.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 15, left: 15),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: DesignTheme.shadowByOpacity(0.05),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: size.width * 0.7,
                child: Text(
                  product.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: -0.3,
                    color: DesignTheme.gray36Color,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                product.calory.toString() +
                    " кКал     " +
                    product.squi.toString() +
                    " Б     " +
                    product.fat.toString() +
                    " Ж     " +
                    product.carboh.toString() +
                    " У",
                style: DesignTheme.secondaryText,
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              splashColor: DesignTheme.mainColor,
              hoverColor: DesignTheme.secondColor,
              onPressed: () => _openProductPage(product, context),
              icon: Icon(
                Icons.add,
                color: DesignTheme.mainColor,
                size: 28,
              ),
            ),
          )
        ],
      ),
    );
  }

  void _openProductPage(Product product, BuildContext context) {
    Navigator.pushNamed(
      context,
      '/product/' + product.id.toString(),
    );
  }
}
