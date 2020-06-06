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

  final TextEditingController _nameController = new TextEditingController( );
  final TextEditingController _surnameController = new TextEditingController( );

  @override
  void initState() {
    super.initState();
    DBUserProvider.db.getUser().then((_user){
      user = _user;
      _nameController.text = user.name;
      _surnameController.text = user.surname;
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
                      if (value.isEmpty) return 'Введите ваше имя';
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
                      if (value.isEmpty) return 'Введите вашу фамилию';
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
                getEditorSaveButtonOnlyName(_formKey, user, context),
          ]),
        ),
        ]
      ),
      ])
      ),
    );
  }
}