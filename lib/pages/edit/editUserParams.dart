import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/models/dbModels.dart';
import 'package:calory_calc/models/userEditRadioModel.dart';
import 'package:calory_calc/pages/forms/customFrom.dart';
import 'package:calory_calc/providers/local_providers/userProvider.dart';
import 'package:calory_calc/utils/convertors/workModelFromTxt.dart';
import 'package:calory_calc/widgets/alerts/easyGoogAlert.dart';
import 'package:calory_calc/widgets/appBars/arrowBackAppBar.dart';
import 'package:calory_calc/widgets/buttons/editorSaveButton.dart';
import 'package:calory_calc/widgets/customInputs/carousel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

class EditUserParamsPage extends StatefulWidget{
  @override
  _EditUserParamsPageState createState() => _EditUserParamsPageState();
}

class _EditUserParamsPageState extends State<EditUserParamsPage> {
  User user = new User();

  List<RadioModel> sampleData = [
    RadioModel(true, 1, 'Минимум физической активности', "slim", "Похудеть", "Диета для", "быстрого похудения", 20),
    RadioModel(false, 2, 'Занимаюсь спортом 1-3 раза в неделю', "normal", "Сохранить вес", "Стандартное, здоровое","питание", 5),
    RadioModel(false, 3, 'Занимаюсь спортом 3-4 раза в неделю', "strong", "Набрать вес", "Диета для ","набора массы", 20)
  ];

  String dropdownValue = 'Минимум физической активности';
  
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _weightController = new TextEditingController( );
  final TextEditingController _heightController = new TextEditingController( );
  final TextEditingController _ageController = new TextEditingController( );

  @override
  void initState() {
    DBUserProvider.db.getUser().then((_user){
      setState((){
        user = _user;
        _weightController.text = user.weight.toString();
        _heightController.text = user.height.toString();
        _ageController.text = user.age.toString();
        sampleData[0].isSelected = user.workFutureModel == 1; 
        sampleData[1].isSelected = user.workFutureModel == 2;
        sampleData[2].isSelected = user.workFutureModel == 3;
        dropdownValue = user.workModel == 1.2 ?'Минимум физической активности': user.workModel == 1.375 ? 'Занимаюсь спортом 1-3 раза в неделю':
        user.workModel == 1.55? 'Занимаюсь спортом 3-4 раза в неделю': user.workModel == 1.7? 'Занимаюсь спортом каждый день' : 'Тренируюсь по несколько раз в день';
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getArrowBackAppBar("Параметры тела", "/editUser", context),
      body: SingleChildScrollView(
        child:
        Stack(
        children: <Widget>[
          Form(key: _formKey, child: 
      Column(
        children:<Widget>[
            Stack(
              children:<Widget>[ 
        Container(
          padding: EdgeInsets.only(left:30, top:30, right:30),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
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
                ]
              ),
            ),
          ]),
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
                    ),
                  ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height/6.5),
              getEditorSaveButton(_formKey, user, context),
        ])
      ),
          ],
        ),
      ),
    );
  }
}