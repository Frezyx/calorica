import 'package:calory_calc/blocs/auth/bloc.dart';
import 'package:calory_calc/providers/local_providers/userProvider.dart';
import 'package:flutter/material.dart';

import 'package:calory_calc/models/dbModels.dart';
import 'package:calory_calc/utils/dataLoader.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  double _workModel;
  int _futureWorkModel;
  bool _gender;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(
          FocusNode(),
        );
      },
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          allowImplicitScrolling: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            WorkModelPickerForm(
              onComplete: (int futureWorkModel) {
                setState(() => _futureWorkModel = futureWorkModel);
                _openNextPage();
              },
            ),
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
                setState(() => _gender = gender);
                _openNextPage();
              },
            ),
            ExerciseStressPickerForm(
              onComplete: (double workModel) {
                setState(() => _workModel = workModel);
                _openNextPage();
              },
            ),
            NameForm(
              nameController: _nameController,
              surnameController: _surnameController,
              onCompleted: (String name, String surname) async {
                User user = User(
                  name: surname,
                  surname: surname,
                  weight: double.tryParse(_weightController.text),
                  height: double.tryParse(_heightController.text),
                  age: double.tryParse(_ageController.text),
                  gender: _gender,
                  workModel: _workModel,
                  workFutureModel: _futureWorkModel,
                );
                registrationAtLocalDB(user);
              },
            ),
          ],
        ),
      ),
    );
  }

  void registrationAtLocalDB(User user) {
    BlocProvider.of<AuthBloc>(context).add(Authorize(user: user));
  }

  void _openNextPage() {
    _pageController.animateToPage(
      _pageController.page.toInt() + 1,
      duration: Duration(milliseconds: 300),
      curve: Curves.bounceInOut,
    );
  }
}
