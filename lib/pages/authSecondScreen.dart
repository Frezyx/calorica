import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/utils/adClickHelper.dart';
import 'package:calory_calc/providers/local_providers/userProvider.dart';
import 'package:calory_calc/widgets/customRadio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

enum SingingCharacter { lafayette, jefferson }

class SecondAuthPage extends StatefulWidget {
  @override
  _SecondAuthPageState createState() => _SecondAuthPageState();
}

class _SecondAuthPageState extends State<SecondAuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  double _weight = 0.0;
  double _height = 0.0;
  bool _gender = true;
  double _age = 0.0;
  double workModel = 0.0;

  bool isFP = true;
  bool isSP = false;
  bool isTP = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/bg2.png"), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              padding: EdgeInsets.only(
                left: 40.0,
                right: 40.0,
                top: MediaQuery.of(context).size.height / 6,
              ),
              child: isFP
                  ? getFP()
                  : isSP
                      ? getSP()
                      : getTP(),
            ),
          ),
        ),
      ),
    );
  }

  getFP() {
    return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                cursorColor: DesignTheme.mainColor,
                decoration: InputDecoration(
                    labelText: 'Вес',
                    labelStyle: DesignTheme.label,
                    suffixIcon: Icon(FontAwesomeIcons.ruler)),
                validator: (value) {
                  if (value.isEmpty)
                    return 'Введите ваш вес';
                  else if (!(double.parse(value) is double))
                    return 'Введите число, а не строку';
                  else {
                    _weight = double.parse(value);
                  }
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                cursorColor: DesignTheme.mainColor,
                decoration: InputDecoration(
                    labelText: 'Рост',
                    labelStyle: DesignTheme.label,
                    suffixIcon: Icon(FontAwesomeIcons.ruler)),
                validator: (value) {
                  if (value.isEmpty)
                    return 'Введите ваш рост';
                  else if (!(double.parse(value) is double))
                    return 'Введите число, а не строку';
                  else {
                    _height = double.parse(value);
                  }
                },
              ),
              SizedBox(height: 10),
              GradientButton(
                increaseWidthBy: 60,
                increaseHeightBy: 5,
                child: Padding(
                  child: Text(
                    'Далее',
                    textAlign: TextAlign.center,
                    style: DesignTheme.buttonText,
                  ),
                  padding:
                      EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
                ),
                callback: () {
                  if (_formKey.currentState.validate()) {
                    if (_weight != null && _height != null) {
                      DBUserProvider.db
                          .updateDateProducts("weight", _weight)
                          .then((count1) {
                        DBUserProvider.db
                            .updateDateProducts("height", _height)
                            .then((count2) {
                          if (count1 == 1 && count2 == 1) {
                            setState(() {
                              isFP = false;
                              isSP = true;
                            });
                          }
                        });
                      });
                    }
                  }
                },
                shapeRadius: BorderRadius.circular(50.0),
                gradient: DesignTheme.gradient,
                shadowColor:
                    Gradients.backToFuture.colors.last.withOpacity(0.25),
              ),
            ]));
  }

  getSP() {
    return Form(
        key: _formKey2,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                cursorColor: DesignTheme.mainColor,
                decoration: InputDecoration(
                    labelText: 'Сколько вам лет ?',
                    labelStyle: DesignTheme.label,
                    suffixIcon: Icon(Icons.calendar_today)),
                validator: (value) {
                  if (value.isEmpty)
                    return 'Введите ваш возраст';
                  else if (!(double.parse(value) is double))
                    return 'Введите число, а не строку';
                  else {
                    _age = double.parse(value);
                  }
                },
              ),
              SizedBox(height: 10),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        left: 0,
                        right: 30,
                        bottom: 15,
                      ),
                      child: Row(children: <Widget>[
                        Radio(
                          value: true,
                          groupValue: _gender,
                          onChanged: (bool value) {
                            setState(() {
                              _gender = value;
                            });
                          },
                        ),
                        Text("Мужчина"),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 15,
                      ),
                      child: Row(children: <Widget>[
                        Radio(
                          value: false,
                          groupValue: _gender,
                          onChanged: (bool value) {
                            setState(() {
                              _gender = value;
                            });
                          },
                        ),
                        Text("Женщина"),
                      ]),
                    ),
                  ]),
              SizedBox(height: 10),
              GradientButton(
                increaseWidthBy: 60,
                increaseHeightBy: 5,
                child: Padding(
                  child: Text(
                    'Далее',
                    textAlign: TextAlign.center,
                    style: DesignTheme.buttonText,
                  ),
                  padding:
                      EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
                ),
                callback: () {
                  if (_formKey2.currentState.validate()) {
                    if (_age != null) {
                      DBUserProvider.db
                          .updateDateProducts("gender", _gender)
                          .then((count1) {
                        DBUserProvider.db
                            .updateDateProducts("age", _age)
                            .then((count2) {
                          if (count1 == 1 && count2 == 1) {
                            setState(() {
                              isSP = false;
                            });
                          }
                        });
                      });
                    }
                  }
                },
                shapeRadius: BorderRadius.circular(50.0),
                gradient: DesignTheme.gradient,
                shadowColor:
                    Gradients.backToFuture.colors.last.withOpacity(0.25),
              ),
            ]));
  }

  getTP() {
    return CustomRadio();
  }
}
