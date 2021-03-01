import 'package:calory_calc/providers/local_providers/userProvider.dart';
import 'package:calory_calc/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:calory_calc/design/theme.dart';

import 'package:calory_calc/models/dbModels.dart';
import 'package:calory_calc/utils/dataLoader.dart';

import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();

  String _name;
  String _surname;
  int state_bg = 0;

  @override
  void initState() {
    super.initState();
    startLoadData();
  }

  void setDefStateBg() {
    setState(() {
      state_bg = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(
            left: 40.0,
            right: 40.0,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  onTap: () {},
                  cursorColor: DesignTheme.mainColor,
                  decoration: InputDecoration(
                      labelText: 'Имя',
                      labelStyle: DesignTheme.label,
                      suffixIcon: Icon(
                        Icons.people,
                      )),
                  validator: (value) {
                    if (value.isEmpty)
                      return 'Введите ваш логин';
                    else {
                      _name = value.toString();
                    }
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  onTap: () {},
                  cursorColor: DesignTheme.mainColor,
                  decoration: InputDecoration(
                      labelText: 'Фамилия',
                      labelStyle: DesignTheme.label,
                      suffixIcon: Icon(
                        Icons.people,
                      )),
                  validator: (value) {
                    if (value.isEmpty)
                      return 'Введите ваш логин';
                    else {
                      _surname = value.toString();
                    }
                  },
                ),
                SizedBox(height: 10),
                CommonButton(
                  child: Text(
                    'Далее',
                    style: Theme.of(context).textTheme.button.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      if (_name != null && _surname != null) {
                        User user = User(name: _name, surname: _surname);
                        registrationAtLocalDB(user).then((res) {
                          if (res) {
                            Navigator.pushNamed(context, '/authSecondScreen');
                          }
                        });
                      }
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool> registrationAtLocalDB(User nowClient) async {
  int res = await DBUserProvider.db.addUser(nowClient);
  return (res == 0);
}
