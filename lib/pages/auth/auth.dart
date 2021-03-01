import 'package:calory_calc/pages/auth/widgets/forms/physical_parameters.dart';
import 'package:calory_calc/providers/local_providers/userProvider.dart';
import 'package:flutter/material.dart';

import 'package:calory_calc/models/dbModels.dart';
import 'package:calory_calc/utils/dataLoader.dart';

import 'widgets/forms/forms.dart';

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

  final _pageController = PageController();

  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          allowImplicitScrolling: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            PhysicalParametersForm(
              ageController: _ageController,
              heightController: _heightController,
              weightController: _weightController,
              onCompleted: (
                String weight,
                String height,
                String age,
                bool gender,
              ) {
                _pageController.animateToPage(
                  _pageController.page.toInt() + 1,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.bounceInOut,
                );
              },
            ),
            NameForm(
              nameController: _nameController,
              surnameController: _surnameController,
              onCompleted: (String name, String surname) async {
                User user = User(name: surname, surname: surname);
                final res = await registrationAtLocalDB(user);
                if (res) {
                  Navigator.pushNamed(context, '/authSecondScreen');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool> registrationAtLocalDB(User nowClient) async {
  int res = await DBUserProvider.db.addUser(nowClient);
  return (res == 0);
}
