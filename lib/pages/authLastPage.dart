import 'package:flutter/material.dart';

import 'package:calory_calc/models/dbModels.dart';
import 'package:calory_calc/utils/adClickHelper.dart';
import 'package:calory_calc/utils/databaseHelper.dart';
import 'package:calory_calc/widgets/customRadioSelector.dart';

class ActivitiSelectPage extends StatefulWidget {

  @override
  _ActivitiSelectPageState createState() => _ActivitiSelectPageState();
}

class _ActivitiSelectPageState extends State<ActivitiSelectPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
     onTap: (){ addClick(); 
        // setDefStateBg();
        FocusScope.of(context).requestFocus(new FocusNode());
      },child: new Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/bg2.png")
                    , fit: BoxFit.cover)),
            child:
        Scaffold(
          backgroundColor: Colors.transparent,
          body: 
          Center(
            child:
              Container(
                padding: EdgeInsets.only(  
                top:MediaQuery.of(context).size.height/6, 
                ),
                  child: getCustomSelector()
            ),
          ),
        ),
      ),
    );
  }

  getCustomSelector(){
    return CustomRadioSelector();
  }
}

  Future<bool> registrationAtLocalDB(User nowClient) async{
      print(nowClient.name + " --- " + nowClient.surname);
      int res = await DBUserProvider.db.addUser(nowClient);
      return(res == 0);
  }