import 'package:calory_calc/common/theme/theme.dart';
import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/widgets/appBars/arrowBackAppBar.dart';
import 'package:calory_calc/widgets/buttons/editorSaveButton.dart';
import 'package:calory_calc/widgets/buttons/flatNavigationButton.dart';

import 'package:flutter/material.dart';

import 'package:calory_calc/providers/local_providers/userProvider.dart';
import 'package:calory_calc/models/dbModels.dart';

class RadioModel {
  bool isSelected;
  final int multiplaier;
  final String text;
  final String icon;
  final String title;
  final String subtitle;
  final double padding;
  final String subSubTitle;

  RadioModel(
    this.isSelected,
    this.multiplaier,
    this.text,
    this.icon,
    this.title,
    this.subtitle,
    this.subSubTitle,
    this.padding,
  );
}

class EditUserPage extends StatefulWidget {
  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final _formKey = GlobalKey<FormState>();
  User user = User();
  String dropdownValue = 'Минимум физической активности';
  int workFutureModel = 1;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    DBUserProvider.db.getUser().then((_user) {
      user = _user;
      _nameController.text = user.name;
      _surnameController.text = user.surname;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getArrowBackAppBar("Настройки", "/navigator/1", context),
      body: Form(
          key: _formKey,
          child: Column(children: <Widget>[
            Stack(children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 30, top: 30, right: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        controller: _nameController,
                        cursorColor: CustomTheme.mainColor,
                        decoration: InputDecoration(
                            labelText: 'Имя',
                            labelStyle: DesignTheme.selectorLabel,
                            suffixIcon: Icon(
                              Icons.people,
                            )),
                        validator: (value) {
                          if (value.isEmpty)
                            return 'Введите ваше имя';
                          else {
                            user.name = value.toString();
                          }
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _surnameController,
                        cursorColor: CustomTheme.mainColor,
                        decoration: InputDecoration(
                            labelText: 'Фамилия',
                            labelStyle: DesignTheme.selectorLabel,
                            suffixIcon: Icon(
                              Icons.people,
                            )),
                        validator: (value) {
                          if (value.isEmpty)
                            return 'Введите вашу фамилию';
                          else {
                            user.surname = value.toString();
                          }
                        },
                      ),
                      SizedBox(height: 40),
                      getFlatNavigationButton(
                          "Личные параметры", "/editUserParams", context),
                      SizedBox(height: 20),
                      getFlatNavigationButton(
                          "Параметры диеты", "/editUserDietParams", context),
                      SizedBox(height: 20),
                      getFlatNavigationButton(
                          "Выбрать диету", "/choiseDiet", context),
                      SizedBox(height: MediaQuery.of(context).size.height / 3),
                      getEditorSaveButtonOnlyName(_formKey, user, context),
                    ]),
              ),
            ]),
          ])),
    );
  }
}
