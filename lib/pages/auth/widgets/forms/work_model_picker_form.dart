import 'package:calory_calc/common/theme/theme.dart';
import 'package:flutter/material.dart';

import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/widgets/widgets.dart';

class WorkModelPickerForm extends StatefulWidget {
  const WorkModelPickerForm({
    Key key,
    this.onComplete,
  }) : super(key: key);

  final Function(int workModel) onComplete;

  @override
  createState() {
    return WorkModelPickerFormState();
  }
}

class WorkModelPickerFormState extends State<WorkModelPickerForm> {
  List<RadioModel> sampleData = List<RadioModel>();
  int workModel = 1;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    sampleData.add(
      RadioModel(
        true,
        1,
        "slim",
        "Похудеть",
        "Диета для быстрого похудения",
        20,
      ),
    );
    sampleData.add(
      RadioModel(
        false,
        2,
        "normal",
        "Сохранить вес",
        "Стандартное, здоровое питание",
        5,
      ),
    );
    sampleData.add(
      RadioModel(
        false,
        3,
        "strong",
        "Набрать вес",
        "Диета для набора массы",
        20,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                "Регистрация",
                style: CustomTheme.title,
              ),
              Text(
                "Выберите свою цель",
                style: CustomTheme.subtitle.copyWith(
                  color: theme.primaryColor,
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 2.3,
                child: ListView.builder(
                  itemCount: sampleData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      highlightColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        setState(() {
                          sampleData
                              .forEach((element) => element.isSelected = false);
                          sampleData[index].isSelected = true;
                          workModel = sampleData[index].multiplaier;
                        });
                      },
                      child: RadioItem(sampleData[index]),
                    );
                  },
                ),
              ),
            ],
          ),
          CommonButton(
            child: Text(
              'Далее',
              style: theme.textTheme.button,
            ),
            onPressed: () => widget.onComplete(workModel),
          )
        ],
      ),
    );
  }
}

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
                _item.isSelected ? DesignTheme.mainColor : Colors.transparent),
        borderRadius: const BorderRadius.all(const Radius.circular(12.0)),
      ),
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.only(left: 20, right: 20, top: 7.5, bottom: 7.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                _item.title,
                style: _item.isSelected
                    ? DesignTheme.selectorBigTextAction
                    : DesignTheme.selectorBigText,
              ),
              Text(_item.subtitle, style: DesignTheme.selectorMiniLabel)
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

class RadioModel {
  bool isSelected;
  final int multiplaier;

  final String icon;
  final String title;
  final String subtitle;
  final double padding;

  RadioModel(this.isSelected, this.multiplaier, this.icon, this.title,
      this.subtitle, this.padding);
}
