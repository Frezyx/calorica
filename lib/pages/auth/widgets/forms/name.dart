import 'package:calory_calc/common/theme/theme.dart';
import 'package:calory_calc/widgets/widgets.dart';
import 'package:flutter/material.dart';

class NameForm extends StatelessWidget {
  NameForm({
    Key key,
    @required this.onCompleted,
    @required this.nameController,
    @required this.surnameController,
  }) : super(key: key);

  final TextEditingController nameController;
  final TextEditingController surnameController;
  final Function(String name, String surname) onCompleted;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          children: [
            Text(
              'Регистрация',
              style: CustomTheme.title,
            ),
            Text(
              'Физические параметры',
              style: CustomTheme.subtitle.copyWith(
                color: theme.primaryColor,
              ),
            ),
          ],
        ),
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                onTap: () {},
                controller: nameController,
                cursorColor: theme.primaryColor,
                decoration: CustomTheme.authInputDecoration.copyWith(
                  labelText: 'Имя',
                ),
                validator: (value) {
                  if (value.isEmpty) return 'Введите ваш логин';
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                onTap: () {},
                controller: surnameController,
                cursorColor: theme.primaryColor,
                decoration: CustomTheme.authInputDecoration.copyWith(
                  labelText: 'Фамилия',
                ),
                validator: (value) {
                  if (value.isEmpty) return 'Введите вашу фамилию';
                },
              ),
            ],
          ),
        ),
        CommonButton(
          child: Text(
            'Далее',
            style: Theme.of(context).textTheme.button.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          onPressed: _onButtonPressed,
        ),
      ],
    );
  }

  void _onButtonPressed() {
    final name = nameController.text;
    final surname = surnameController.text;
    if (_formKey.currentState.validate()) {
      if (name != null &&
          name.isNotEmpty &&
          surname != null &&
          surname.isNotEmpty) {
        onCompleted(nameController.text, surnameController.text);
        // User user = User(name: _name, surname: _surname);
        // registrationAtLocalDB(user).then((res) {
        //   if (res) {
        //     Navigator.pushNamed(context, '/authSecondScreen');
        //   }
        // });
      }
    }
  }
}
