import 'package:calory_calc/common/theme/theme.dart';
import 'package:calory_calc/providers/local_providers/userProvider.dart';
import 'package:calory_calc/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:calory_calc/design/theme.dart';

import 'package:calory_calc/models/dbModels.dart';
import 'package:calory_calc/utils/dataLoader.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();

  String _name;
  String _surname;

  @override
  void initState() {
    super.initState();
    startLoadData();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(40),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Регистрация'),
                Column(
                  children: [
                    TextFormField(
                      onTap: () {},
                      cursorColor: theme.primaryColor,
                      decoration: CustomTheme.authInputDecoration.copyWith(
                        labelText: 'Имя',
                      ),
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
                      cursorColor: theme.primaryColor,
                      decoration: CustomTheme.authInputDecoration.copyWith(
                        labelText: 'Фамилия',
                      ),
                      validator: (value) {
                        if (value.isEmpty)
                          return 'Введите вашу фамилию';
                        else {
                          _surname = value.toString();
                        }
                      },
                    ),
                  ],
                ),
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
