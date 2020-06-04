import 'dart:math';

import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/utils/adClickHelper.dart';
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
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){ addClick();
              Navigator.popAndPushNamed(context, "/navigator/1");
            },
            icon:Icon(Icons.arrow_back, size: 24,)
          ),
        elevation: 5.0,
        backgroundColor: DesignTheme.whiteColor,
        title: Text("Редактирование профиля",style: TextStyle(fontWeight: FontWeight.w700),),
      ),
      body: SingleChildScrollView(
        child:
    Stack(
    children:<Widget>[ 
      new Form(key: _formKey, child: 
      Column(
        children:<Widget>[
            Stack(
              children:<Widget>[ 
        Container(
          padding: EdgeInsets.only(left:30, right:30),
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

                new SizedBox(height: 10),

                new TextFormField(
                      controller: _weightController,
                      cursorColor: DesignTheme.mainColor,
                      decoration: InputDecoration(
                        labelText: 'Вес',
                        labelStyle: DesignTheme.selectorLabel,
                        suffixIcon: Icon(
                            FontAwesomeIcons.ruler,
                          )
                    ),
                    validator: (value){
                      if (value.isEmpty) return 'Введите ваш логин';
                      else {
                        user.weight = double.parse(value);
                      }
                  },
                ),

                new SizedBox(height: 10),

                new TextFormField(
                      controller: _heightController,
                      cursorColor: DesignTheme.mainColor,
                      decoration: InputDecoration(
                        labelText: 'Рост',
                        labelStyle: DesignTheme.selectorLabel,
                        suffixIcon: Icon(
                            FontAwesomeIcons.ruler,
                          )
                    ),
                    validator: (value){
                      if (value.isEmpty) return 'Введите ваш логин';
                      else {
                        user.height = double.parse(value);
                      }
                  },
                ),

                new SizedBox(height: 10),

                new TextFormField(
                      controller: _ageController,
                      cursorColor: DesignTheme.mainColor,
                      decoration: InputDecoration(
                        labelText: 'Возраст',
                        labelStyle: DesignTheme.selectorLabel,
                        suffixIcon: Icon(
                            Icons.calendar_today,
                          )
                    ),
                    validator: (value){
                      if (value.isEmpty) return 'Введите ваш логин';
                      else {
                        user.age = double.parse(value);
                      }
                  },
                ),

                new SizedBox(height: 10),

                DropdownButton<String>(
                    value: dropdownValue,
                    icon: Icon(Icons.arrow_downward, color: DesignTheme.mainColor,),
                    iconSize: 24,
                    elevation: 2,
                    style: TextStyle(
                      color: DesignTheme.gray50Color
                    ),
                    underline: Container(
                      height: 2,
                      color: DesignTheme.mainColor,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                        user.workModel = getWorkModelFromText(newValue);
                      });
                    },
                    items: <String>[ 'Минимум физической активности','Занимаюсь спортом 1-3 раза в неделю','Занимаюсь спортом 3-4 раза в неделю', 'Занимаюсь спортом каждый день', 'Тренируюсь по несколько раз в день']
                      .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      })
                      .toList(),
                  ),
              SizedBox(height: 10,),
          ]),
        ),
        ]
      ),
          Container(
                height: 150,
                child:
                CarouselSlider.builder(
                  itemCount: 3,
                  itemBuilder:  (context, index){
                    return new InkWell(
                      highlightColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      child: new RadioItem(sampleData[index]),
                    );},
                    options: CarouselOptions(
                          initialPage: sampleData[1].isSelected ? 1 : sampleData[2].isSelected ? 2 : 3,
                          height: 150.0,
                          viewportFraction: 0.7,
                          autoPlay: false,
                          autoPlayCurve: Curves.elasticIn,
                          onPageChanged: (index, reason) {
                            print(index);
                            setState(() {
                              sampleData.forEach((element) => element.isSelected = false);
                              sampleData[index].isSelected = true;
                              user.workFutureModel = sampleData[index].multiplaier;
                            });
                          }
                        //   onPageChanged: (i){
                        //     print(i);
                        //   // setState(() {

                        //   //   sampleData.forEach((element) => element.isSelected = false);
                        //   //   sampleData[index].isSelected = true;
                        //   //   user.workFutureModel = sampleData[index].multiplaier;
                        //   // });
                        // }
                    ),
                  ),
              ),
          

              SizedBox(height: 10),

                GradientButton(
                  increaseWidthBy: 60,
                  increaseHeightBy: 5,
                  child: 
                  Padding(
                    child:Text(
                    'Сохранить',
                    textAlign: TextAlign.center,
                    style: DesignTheme.buttonText,
                    ), padding: EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
                  ),
                  callback: () {
                    if(_formKey.currentState.validate()){
                      DBUserProvider.db.updateUser(user).then((count){
                        if(count == 1){
                          _goodAllert(context);
                        }
                      });
                    }
                  },
                  shapeRadius: BorderRadius.circular(50.0),
                  gradient: DesignTheme.gradient,
                  shadowColor: Gradients.backToFuture.colors.last.withOpacity(0.0),
                ),
      ])
      ),
      ])
      )
    );
  }
    Future<void> _goodAllert(context) async {
                    return showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: Text('Данные сохранены'),
                            actions: <Widget>[
                                  FlatButton(
                                    child: Text('Отлично', style: TextStyle(color: DesignTheme.mainColor ),),
                                    
                                    onPressed: (){ addClick();
                                      Navigator.pop(context);
                                    },
                                  ),
                                ]
                              );
                            
                          },
                        );
                      }

  double getWorkModelFromText(text){
    double result = 1.2;
      result = text == 'Минимум физической активности' ? 1.2: user.workModel == 'Занимаюсь спортом 1-3 раза в неделю'? 1.375:
      user.workModel == 'Занимаюсь спортом 3-4 раза в неделю' ? 1.55: user.workModel == 'Занимаюсь спортом каждый день' ? 1.7 : 1.9;
    return result;
  }
  Widget _simplePopup() => PopupMenuButton<int>(
          itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Text("First"),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Text("Second"),
                ),
              ],
        );
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return new Container(
        decoration: new BoxDecoration(
          boxShadow: _item.isSelected? [DesignTheme.selectorShadow] : [DesignTheme.transperentShadow],
          color: _item.isSelected ? DesignTheme.whiteColor: DesignTheme.selectorGrayBackGround,
              border: new Border.all(
                  width: 1.0,
                  color: _item.isSelected? DesignTheme.mainColor: Colors.transparent),
              borderRadius: const BorderRadius.all(const Radius.circular(12.0)),
            ),
      padding: new EdgeInsets.only(left:20, right:20, top: 7.5,bottom: 7.5),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
               child:
            Text(_item.title, style: _item.isSelected? DesignTheme.selectorBigTextAction : DesignTheme.selectorBigText,)),
            Flexible(
               child:
            Text(_item.subtitle, style: DesignTheme.selectorMiniLabel )),
            Flexible(
               child:
            Text(_item.subSubTitle, style: DesignTheme.selectorMiniLabel ))
          ],),
          Padding(
            padding: new EdgeInsets.only(right:_item.padding),
            child: Container(
              child: _item.isSelected ? Image.asset("assets/selector/"+_item.icon+"Color.png", height: 80,) : Image.asset("assets/selector/"+_item.icon+".png", height: 80,),
            ),
          )
        ],
      ),
    );
  }
}