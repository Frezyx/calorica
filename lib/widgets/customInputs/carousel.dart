import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/common/theme/theme.dart';
import 'package:calory_calc/models/userEditRadioModel.dart';
import 'package:flutter/material.dart';

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: _item.isSelected
            ? [DesignTheme.selectorShadow]
            : [DesignTheme.transperentShadow],
        color: _item.isSelected
            ? DesignTheme.whiteColor
            : DesignTheme.selectorGrayBackGround,
        border: Border.all(
            width: 1.0,
            color:
                _item.isSelected ? CustomTheme.mainColor : Colors.transparent),
        borderRadius: const BorderRadius.all(const Radius.circular(12.0)),
      ),
      padding: EdgeInsets.only(left: 20, right: 20, top: 7.5, bottom: 7.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                  child: Text(
                _item.title,
                style: _item.isSelected
                    ? DesignTheme.selectorBigTextAction
                    : DesignTheme.selectorBigText,
              )),
              Flexible(
                  child: Text(_item.subtitle,
                      style: DesignTheme.selectorMiniLabel)),
              Flexible(
                  child: Text(_item.subSubTitle,
                      style: DesignTheme.selectorMiniLabel))
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: _item.padding),
            child: Container(
              child: _item.isSelected
                  ? Image.asset(
                      "assets/selector/" + _item.icon + "Color.png",
                      height: 80,
                    )
                  : Image.asset(
                      "assets/selector/" + _item.icon + ".png",
                      height: 80,
                    ),
            ),
          )
        ],
      ),
    );
  }
}
