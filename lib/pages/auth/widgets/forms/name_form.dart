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
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
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
                  'Личные данные',
                  style: CustomTheme.subtitle.copyWith(
                    color: theme.primaryColor,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                TextFormField(
                  onTap: () {},
                  controller: nameController,
                  cursorColor: theme.primaryColor,
                  decoration: CustomTheme.authInputDecoration.copyWith(
                    labelText: 'Имя',
                  ),
                  validator: (value) {
                    if (value.isEmpty)
                      return 'Введите ваш логин';
                    else
                      return null;
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
                    if (value.isEmpty)
                      return 'Введите вашу фамилию';
                    else
                      return null;
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
              onPressed: () => _onButtonPressed(context),
            ),
          ],
        ),
      ),
    );
  }

  void _onButtonPressed(BuildContext context) {
    final name = nameController.text;
    final surname = surnameController.text;
    if (_formKey.currentState.validate()) {
      if (name != null &&
          name.isNotEmpty &&
          surname != null &&
          surname.isNotEmpty) {
        onCompleted(name, surname);
      }
    }
  }
}
