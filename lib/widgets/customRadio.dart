import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/providers/local_providers/userProvider.dart';
import 'package:flutter/material.dart';

class CustomRadio extends StatefulWidget {
  @override
  createState() {
    return CustomRadioState();
  }
}

class CustomRadioState extends State<CustomRadio> {
  List<RadioModel> sampleData = List<RadioModel>();

  @override
  void initState() {
    super.initState();
    sampleData.add(RadioModel(false, 1.2, 'Минимум физической активности'));
    sampleData
        .add(RadioModel(false, 1.375, 'Занимаюсь спортом 1-3 раза в неделю'));
    sampleData
        .add(RadioModel(false, 1.55, 'Занимаюсь спортом 3-4 раза в неделю'));
    sampleData.add(RadioModel(false, 1.7, 'Занимаюсь спортом каждый день'));
    sampleData
        .add(RadioModel(false, 1.9, 'Тренируюсь по несколько раз в день'));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Padding(
        padding: EdgeInsets.only(top: 120),
        child: Text(
          "Выберите Степень вашей физической активности: ",
          style: DesignTheme.label,
        ),
      ),
      Padding(
          padding: EdgeInsets.only(top: 170),
          child: ListView.builder(
            itemCount: sampleData.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                highlightColor: DesignTheme.secondColor,
                focusColor: DesignTheme.secondColor,
                splashColor: DesignTheme.secondColor,
                onTap: () {
                  setState(() {
                    sampleData.forEach((element) => element.isSelected = false);
                    sampleData[index].isSelected = true;
                  });
                  DBUserProvider.db
                      .updateDateProducts(
                          "workModel", sampleData[index].multiplaier)
                      .then((count1) {
                    if (count1 == 1) {
                      Navigator.pushNamed(context, '/selectActiviti');
                    } else {
                      // TODO : Alert
                    }
                  });
                },
                child: RadioItem(sampleData[index]),
              );
            },
          )),
    ]);
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 0),
            child: Container(
              height: 25.0,
              width: 25.0,
              child: Center(
                child: Icon(Icons.check,
                    color: _item.isSelected ? Colors.white : Colors.black,
                    size: 18.0),
              ),
              decoration: BoxDecoration(
                color: _item.isSelected
                    ? DesignTheme.secondColor
                    : Colors.transparent,
                border: Border.all(
                    width: 1.0,
                    color: _item.isSelected
                        ? DesignTheme.secondColor
                        : Colors.grey),
                borderRadius:
                    const BorderRadius.all(const Radius.circular(2.0)),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0),
            child: Column(children: [
              Text(
                _item.text,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.03),
              )
            ]),
          )
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final double multiplaier;
  final String text;

  RadioModel(this.isSelected, this.multiplaier, this.text);
}
