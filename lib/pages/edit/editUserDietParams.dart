import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/models/dbModels.dart';
import 'package:calory_calc/models/diet.dart';
import 'package:calory_calc/models/userEditRadioModel.dart';
import 'package:calory_calc/providers/local_providers/dietProvider.dart';
import 'package:calory_calc/providers/local_providers/userProvider.dart';
import 'package:calory_calc/utils/convertors/workModelFromTxt.dart';
import 'package:calory_calc/widgets/appBars/arrowBackAppBar.dart';
import 'package:calory_calc/widgets/buttons/editorSaveButton.dart';
import 'package:calory_calc/widgets/customInputs/carousel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditDietParamsPage extends StatefulWidget{
  @override
  _EditDietParamsPageState createState() => _EditDietParamsPageState();
}

class _EditDietParamsPageState extends State<EditDietParamsPage> {
  Diet diet = new Diet();
  
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _caloryLimitController = new TextEditingController( );
  final TextEditingController _carbohLimitController = new TextEditingController( );
  final TextEditingController _squiLimitController = new TextEditingController( );
  final TextEditingController _fatLimitController = new TextEditingController( );

  @override
  void initState() {
    DBDietProvider.db.getDietById(1).then((_diet){
      setState((){
        diet = _diet;
        
        _caloryLimitController.text = diet.calory.toString();
        _carbohLimitController.text = diet.carboh.toString();
        _squiLimitController.text = diet.squi.toString();
        _fatLimitController.text = diet.fat.toString();
        
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
                      controller: _caloryLimitController,
                      cursorColor: DesignTheme.mainColor,
                      decoration: InputDecoration(
                        labelText: 'Лимит калорий',
                        labelStyle: DesignTheme.selectorLabel,
                        suffixIcon: Icon(
                            FontAwesomeIcons.ruler,
                          )
                    ),
                    validator: (value){
                      if (value.isEmpty) return 'Введите лимит калорий в день';
                      if (!(double.parse(value) is double)) return 'Введите число';
                      else {
                        diet.calory = double.parse(value);
                      }
                  },
                ),

                new SizedBox(height: 10),

                new TextFormField(
                      controller: _squiLimitController,
                      cursorColor: DesignTheme.mainColor,
                      decoration: InputDecoration(
                        labelText: 'Лимит белков',
                        labelStyle: DesignTheme.selectorLabel,
                        suffixIcon: Icon(
                            FontAwesomeIcons.ruler,
                          )
                    ),
                    validator: (value){
                      if (value.isEmpty) return 'Введите лимит белков в день';
                      if (!(double.parse(value) is double)) return 'Введите число';
                      else {
                        diet.squi = double.parse(value);
                      }
                  },
                ),

                new SizedBox(height: 10),

                new TextFormField(
                      controller: _fatLimitController,
                      cursorColor: DesignTheme.mainColor,
                      decoration: InputDecoration(
                        labelText: 'Лимит жиров',
                        labelStyle: DesignTheme.selectorLabel,
                        suffixIcon: Icon(
                            Icons.calendar_today,
                          )
                    ),
                    validator: (value){
                      if (value.isEmpty) return 'Введите лимит жиров в день';
                      if (!(double.parse(value) is double)) return 'Введите число';
                      else {
                        diet.fat = double.parse(value);
                      }
                  },
                ),
                SizedBox(height: 10,),
                
                new TextFormField(
                      controller: _carbohLimitController,
                      cursorColor: DesignTheme.mainColor,
                      decoration: InputDecoration(
                        labelText: 'Лимит углеводов',
                        labelStyle: DesignTheme.selectorLabel,
                        suffixIcon: Icon(
                            Icons.calendar_today,
                          )
                    ),
                    validator: (value){
                      if (value.isEmpty) return 'Введите лимит углеводов в день';
                      if (!(double.parse(value) is double)) return 'Введите число';
                      else {
                        diet.carboh = double.parse(value);
                      }
                  },
                ),
                SizedBox(height: 10),

                ]
              ),
            ),
          ]),
              SizedBox(height: MediaQuery.of(context).size.height/6.5),
              getEditorDietSaveButton(_formKey, diet, context),
        ])
      ),
          ],
        ),
      ),
    );
  }
}