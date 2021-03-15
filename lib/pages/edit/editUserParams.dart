import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/common/theme/theme.dart';
import 'package:calory_calc/models/dbModels.dart';
import 'package:calory_calc/models/userEditRadioModel.dart';
import 'package:calory_calc/providers/local_providers/userProvider.dart';
import 'package:calory_calc/common/utils/convertors/workModelFromTxt.dart';
import 'package:calory_calc/common/utils/userDietUpdate.dart';
import 'package:calory_calc/widgets/alerts/easyGoogAlert.dart';
import 'package:calory_calc/widgets/appBars/arrowBackAppBar.dart';
import 'package:calory_calc/widgets/customInputs/carousel.dart';
import 'package:calory_calc/widgets/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditUserParamsPage extends StatefulWidget {
  @override
  _EditUserParamsPageState createState() => _EditUserParamsPageState();
}

class _EditUserParamsPageState extends State<EditUserParamsPage> {
  User user = User();

  List<RadioModel> sampleData = [
    RadioModel(true, 1, 'Минимум физической активности', "slim", "Похудеть",
        "Диета для", "быстрого похудения", 20),
    RadioModel(false, 2, 'Занимаюсь спортом 1-3 раза в неделю', "normal",
        "Сохранить вес", "Стандартное, здоровое", "питание", 5),
    RadioModel(false, 3, 'Занимаюсь спортом 3-4 раза в неделю', "strong",
        "Набрать вес", "Диета для ", "набора массы", 20)
  ];

  String dropdownValue = 'Минимум физической активности';

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  void initState() {
    DBUserProvider.db.getUser().then((_user) {
      setState(() {
        user = _user;

        _weightController.text = user.weight.toString();
        _heightController.text = user.height.toString();
        _ageController.text = user.age.toString();

        sampleData[0].isSelected = user.workFutureModel == 1;
        sampleData[1].isSelected = user.workFutureModel == 2;
        sampleData[2].isSelected = user.workFutureModel == 3;
        dropdownValue = user.workModel == 1.2
            ? 'Минимум физической активности'
            : user.workModel == 1.375
                ? 'Занимаюсь спортом 1-3 раза в неделю'
                : user.workModel == 1.55
                    ? 'Занимаюсь спортом 3-4 раза в неделю'
                    : user.workModel == 1.7
                        ? 'Занимаюсь спортом каждый день'
                        : 'Тренируюсь по несколько раз в день';
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getArrowBackAppBar("Параметры тела", "/editUser", context),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Stack(children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 30, top: 30, right: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        controller: _weightController,
                        cursorColor: CustomTheme.mainColor,
                        decoration: InputDecoration(
                            labelText: 'Вес',
                            labelStyle: DesignTheme.selectorLabel,
                            suffixIcon: Icon(
                              FontAwesomeIcons.ruler,
                            )),
                        validator: (value) {
                          if (value.isEmpty) return 'Введите ваш вес';
                          if (!(double.parse(value) is double))
                            return 'Введите число';
                          else {
                            user.weight = double.parse(value);
                          }
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _heightController,
                        cursorColor: CustomTheme.mainColor,
                        decoration: InputDecoration(
                            labelText: 'Рост',
                            labelStyle: DesignTheme.selectorLabel,
                            suffixIcon: Icon(
                              FontAwesomeIcons.ruler,
                            )),
                        validator: (value) {
                          if (value.isEmpty) return 'Введите ваш рост';
                          if (!(double.parse(value) is double))
                            return 'Введите число';
                          else {
                            user.height = double.parse(value);
                          }
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _ageController,
                        cursorColor: CustomTheme.mainColor,
                        decoration: InputDecoration(
                            labelText: 'Возраст',
                            labelStyle: DesignTheme.selectorLabel,
                            suffixIcon: Icon(
                              Icons.calendar_today,
                            )),
                        validator: (value) {
                          if (value.isEmpty) return 'Введите ваш возраст';
                          if (!(double.parse(value) is double))
                            return 'Введите число';
                          else {
                            user.age = double.parse(value);
                          }
                        },
                      ),
                      SizedBox(height: 10),
                      DropdownButton<String>(
                        value: dropdownValue,
                        icon: Icon(
                          Icons.arrow_downward,
                          color: CustomTheme.mainColor,
                        ),
                        iconSize: 24,
                        elevation: 2,
                        style: TextStyle(color: DesignTheme.gray50Color),
                        underline: Container(
                          height: 2,
                          color: CustomTheme.mainColor,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                            user.workModel = getWorkModelFromText(newValue);
                          });
                        },
                        items: <String>[
                          'Минимум физической активности',
                          'Занимаюсь спортом 1-3 раза в неделю',
                          'Занимаюсь спортом 3-4 раза в неделю',
                          'Занимаюсь спортом каждый день',
                          'Тренируюсь по несколько раз в день'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ]),
              ),
            ]),
            Container(
              height: 150,
              child: CarouselSlider.builder(
                itemCount: sampleData.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    highlightColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RadioItem(sampleData[index]),
                    ),
                  );
                },
                options: CarouselOptions(
                    initialPage: sampleData.indexWhere((e) => e.isSelected),
                    height: 150.0,
                    viewportFraction: 0.7,
                    autoPlay: false,
                    autoPlayCurve: Curves.elasticIn,
                    onPageChanged: (index, reason) {
                      setState(() {
                        sampleData
                            .forEach((element) => element.isSelected = false);
                        sampleData[index].isSelected = true;
                        user.workFutureModel = sampleData[index].multiplaier;
                      });
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
                bottom: 40,
              ),
              child: CommonButton(
                child: Text(
                  'Сохранить',
                  style: Theme.of(context).textTheme.button,
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    DBUserProvider.db.updateUser(user).then(
                      (count) {
                        updateDiet(user);
                        if (count == 1) {
                          goodAlert(context);
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
