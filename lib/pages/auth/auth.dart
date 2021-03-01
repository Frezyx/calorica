import 'package:calory_calc/providers/local_providers/userProvider.dart';
import 'package:flutter/material.dart';

import 'package:calory_calc/models/dbModels.dart';
import 'package:calory_calc/utils/dataLoader.dart';

import 'widgets/widgets.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void initState() {
    super.initState();
    startLoadData();
  }

  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(40),
          child: NameForm(
            nameController: _nameController,
            surnameController: _surnameController,
            onCompleted: (String name, String surname) {},
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
