import 'package:calory_calc/common/theme/theme.dart';
import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/common/theme/theme.dart';
import 'package:flutter/material.dart';

class ProductSearchBar extends StatelessWidget {
  const ProductSearchBar({
    Key key,
    @required this.onChanged,
  }) : super(key: key);

  final Function(String text) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15, bottom: 20, left: 10, right: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: DesignTheme.whiteColor,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15.0,
              spreadRadius: 4.0,
              offset: Offset(
                0.0,
                5.0,
              ),
            )
          ],
        ),
        child: TextFormField(
          onChanged: onChanged,
          style: DesignTheme.inputText,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            icon: Padding(
              padding: EdgeInsets.only(
                left: 15,
              ),
              child: Icon(
                Icons.search,
                color: CustomTheme.mainColor,
              ),
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
            labelText: 'Поиск по продуктам...',
            border: InputBorder.none,
            labelStyle: DesignTheme.labelSearchText,
          ),
          onEditingComplete: () {},
        ),
      ),
    );
  }
}
