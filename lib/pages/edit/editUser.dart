import 'dart:math';

import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/utils/adClickHelper.dart';
import 'package:calory_calc/widgets/appBars/arrowBackAppBar.dart';
import 'package:calory_calc/widgets/buttons/editorSaveButton.dart';
import 'package:calory_calc/widgets/buttons/flatNavigationButton.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:calory_calc/providers/local_providers/userProvider.dart';
import 'package:calory_calc/models/dbModels.dart';
import 'package:gradient_widgets/gradient_widgets.dart';


class RadioModel {
  bool isSelected;
  final int multiplaier;
  final String text;
  final String icon;
  final String title;
  final String subtitle;
  final double padding;
  final String subSubTitle;

  RadioModel(this.isSelected, this.multiplaier, this.text, this.icon, this.title, this.subtitle,this.subSubTitle , this.padding,);
}

class EditUserPage extends StatefulWidget{

  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final _formKey = GlobalKey<FormState>();
  User user = new User();
  String dropdownValue = 'Минимум физической активности';
  int workFutureModel = 1; 
  List<RadioModel> sampleData = [
    RadioModel(true, 1, 'Минимум физической активности', "slim", "Похудеть", "Диета для", "быстрого похудения", 20),
    RadioModel(false, 2, 'Занимаюсь спортом 1-3 раза в неделю', "normal", "Сохранить вес", "Стандартное, здоровое","питание", 5),
    RadioModel(false, 3, 'Занимаюсь спортом 3-4 раза в неделю', "strong", "Набрать вес", "Диета для ","набора массы", 20)
    ];

  final TextEditingController _nameController = new TextEditingController( );
  final TextEditingController _surnameController = new TextEditingController( );
  final TextEditingController _weightController = new TextEditingController( );
  final TextEditingController _heightController = new TextEditingController( );
  final TextEditingController _ageController = new TextEditingController( );

  @override
  void initState() {
    super.initState();
    DBUserProvider.db.getUser().then((userFromBD){
      user = userFromBD;
      _nameController.text = user.name;
      _surnameController.text = user.surname;
      _weightController.text = user.weight.toString();
      _heightController.text = user.height.toString();
      _ageController.text = user.age.toString();
      workFutureModel = user.workFutureModel;
      sampleData[0].isSelected = workFutureModel == 1; 
      sampleData[1].isSelected = workFutureModel == 2;
      sampleData[2].isSelected = workFutureModel == 3;

      dropdownValue = user.workModel == 1.2 ?'Минимум физической активности': user.workModel == 1.375 ? 'Занимаюсь спортом 1-3 раза в неделю':
      user.workModel == 1.55? 'Занимаюсь спортом 3-4 раза в неделю': user.workModel == 1.7? 'Занимаюсь спортом каждый день' : 'Тренируюсь по несколько раз в день';
    });
  }

  
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getArrowBackAppBar("Настройки", "/navigator/1", context),
      body: Form(key: _formKey, child: 
      Column(
        children:<Widget>[
            Stack(
              children:<Widget>[ 
        Container(
          padding: EdgeInsets.only(left:30, top:30, right:30),
          child:
                    Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                new TextFormField(
                      controller: _nameController,
                      cursorColor: DesignTheme.mainColor,
                      decoration: InputDecoration(
                        labelText: 'Имя',
                        labelStyle: DesignTheme.selectorLabel,
                        suffixIcon: Icon(
                            Icons.people,
                          )
                    ),
                    validator: (value){
                      if (value.isEmpty) return 'Введите ваш логин';
                      else {
                        user.name = value.toString();
                      }
                  },
                ),

                new SizedBox(height: 10),

                new TextFormField(
                      controller: _surnameController,
                      cursorColor: DesignTheme.mainColor,
                      decoration: InputDecoration(
                        labelText: 'Фамилия',
                        labelStyle: DesignTheme.selectorLabel,
                        suffixIcon: Icon(
                            Icons.people,
                          )
                    ),
                    validator: (value){
                      if (value.isEmpty) return 'Введите ваш логин';
                      else {
                        user.surname = value.toString();
                      }
                  },
                ),

                new SizedBox(height: 40),
                getFlatNavigationButton("Личные параметры", "/editUserParams", context),

                new SizedBox(height: 20),
                getFlatNavigationButton("Параметры диеты", "/editUserDietParams", context),

                new SizedBox(height: 20),
                getFlatNavigationButton("Выбрать диету", "/choiseDiet", context),

                SizedBox(height: MediaQuery.of(context).size.height/3),
                getEditorSaveButton(_formKey, user, context, false),
          ]),
        ),
        ]
      ),
      ])
      ),
    );
  }
}