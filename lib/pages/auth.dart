import 'package:calory_calc/providers/local_providers/userProvider.dart';
import 'package:calory_calc/utils/adClickHelper.dart';
import 'package:flutter/material.dart';
import 'package:calory_calc/design/theme.dart';

import 'package:calory_calc/models/dbModels.dart';
import 'package:calory_calc/utils/dataLoader.dart';

import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatefulWidget {

  AuthPage({SharedPreferences prefs,}): _prefs = prefs;
  SharedPreferences _prefs;

  @override
  _AuthPageState createState() => _AuthPageState(_prefs);
}

class _AuthPageState extends State<AuthPage> {
  _AuthPageState(this.prefs);

  final _formKey = GlobalKey<FormState>();
  SharedPreferences prefs;

  String _name;
  String _surname;
  int state_bg = 0;

  @override
    void initState() {
      super.initState();
      startLoadData();
    }

  void setStateBg() {
    setState(() {
      state_bg += 1;
    });
  }

  void setDefStateBg() {
    setState(() {
      state_bg = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
 onTap: (){ addClick(); 
    setDefStateBg();
    FocusScope.of(context).requestFocus(new FocusNode());
  },child: new Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: state_bg == 0? AssetImage("assets/bg.png") :AssetImage("assets/bg2.png")
                , fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            padding: EdgeInsets.only(left: 40.0, right: 40.0, 
            top:MediaQuery.of(context).size.height/3.5, 
            ),
              child: new Form(key: _formKey, child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

              new TextFormField(
                   onTap: (){ addClick(); 
                      setStateBg();
                    },
                    cursorColor: DesignTheme.mainColor,
                    decoration: InputDecoration(
                      labelText: 'Имя',
                      labelStyle: DesignTheme.label,
                      suffixIcon: Icon(
                          Icons.people,
                        )
                  ),
                  validator: (value){
                    if (value.isEmpty) return 'Введите ваш логин';
                    else {
                      _name = value.toString();
                    }
                },
              ),

              new SizedBox(height: 10),

              new TextFormField(
                   onTap: (){ addClick(); 
                      setStateBg();
                    },
                    cursorColor: DesignTheme.mainColor,
                    decoration: InputDecoration(
                      labelText: 'Фамилия',
                      labelStyle: DesignTheme.label,
                      suffixIcon: Icon(
                          Icons.people,
                        )
                  ),
                  validator: (value){
                    if (value.isEmpty) return 'Введите ваш логин';
                    else {
                      _surname = value.toString();
                    }
                },
              ),

              new SizedBox(height: 10),

              GradientButton(
                increaseWidthBy: 60,
                increaseHeightBy: 5,
                child: 
                Padding(
                  child:Text(
                  'Далее',
                  textAlign: TextAlign.center,
                  style: DesignTheme.buttonText,
                  ), padding: EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
                ),
                callback: () {
                  if(_formKey.currentState.validate()){
                    if(_name != null && _surname != null){
                      User user = User(
                        name: _name,
                        surname: _surname
                      );
                      registrationAtLocalDB(user).then((res){
                        if(res){
                          prefs.setBool('banner', false); 
                            Navigator.pushNamed(context, '/authSecondScreen');
                        }
                      });
                    }
                  }
                },
                shapeRadius: BorderRadius.circular(50.0),
                gradient: DesignTheme.gradient,
                shadowColor: Gradients.backToFuture.colors.last.withOpacity(0.25),
              ),
              ]),
          ),
        ),
        )
      ), 
    );
  }
}

  Future<bool> registrationAtLocalDB(User nowClient) async{
      int res = await DBUserProvider.db.addUser(nowClient);
      return(res == 0);
  }