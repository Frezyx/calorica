import 'package:calory_calc/common/theme/theme.dart';
import 'package:calory_calc/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PhysicalParametersForm extends StatefulWidget {
  PhysicalParametersForm({
    Key key,
    @required this.onCompleted,
    @required this.weightController,
    @required this.heightController,
    @required this.ageController,
  }) : super(key: key);

  final TextEditingController weightController;
  final TextEditingController heightController;
  final TextEditingController ageController;

  final Function(String weight, String height, String age, bool gender)
      onCompleted;

  @override
  _PhysicalParametersFormState createState() => _PhysicalParametersFormState();
}

class _PhysicalParametersFormState extends State<PhysicalParametersForm> {
  bool _gender = true;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
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
                  controller: widget.weightController,
                  cursorColor: theme.primaryColor,
                  keyboardType: TextInputType.number,
                  decoration: CustomTheme.authInputDecoration.copyWith(
                    labelText: 'Вес',
                  ),
                  validator: (value) {
                    if (value.isEmpty)
                      return 'Введите ваш вес';
                    else if (double.tryParse(value) == null)
                      return 'Введите число';
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  onTap: () {},
                  controller: widget.heightController,
                  cursorColor: theme.primaryColor,
                  keyboardType: TextInputType.number,
                  decoration: CustomTheme.authInputDecoration.copyWith(
                    labelText: 'Рост',
                  ),
                  validator: (value) {
                    if (value.isEmpty)
                      return 'Введите ваш рост';
                    else if (double.tryParse(value) == null)
                      return 'Введите число';
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  onTap: () {},
                  controller: widget.ageController,
                  cursorColor: theme.primaryColor,
                  keyboardType: TextInputType.number,
                  decoration: CustomTheme.authInputDecoration.copyWith(
                    labelText: 'Возраст',
                  ),
                  validator: (value) {
                    if (value.isEmpty)
                      return 'Введите ваш рост';
                    else if (double.tryParse(value) == null)
                      return 'Введите число';
                  },
                ),
                SizedBox(height: 10),
                _buildGenderPicker(),
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
      ),
    );
  }

  Row _buildGenderPicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          children: <Widget>[
            Radio(
              value: true,
              groupValue: _gender,
              onChanged: (bool value) {
                setState(
                  () {
                    _gender = value;
                  },
                );
              },
            ),
            Text("Мужчина"),
          ],
        ),
        Row(
          children: [
            Radio(
              value: false,
              groupValue: _gender,
              onChanged: (bool value) {
                setState(
                  () {
                    _gender = value;
                  },
                );
              },
            ),
            Text("Женщина"),
          ],
        ),
      ],
    );
  }

  void _onButtonPressed() {
    final weight = widget.weightController.text;
    final height = widget.heightController.text;
    final age = widget.ageController.text;

    if (_formKey.currentState.validate()) {
      if (weight != null &&
          weight.isNotEmpty &&
          height != null &&
          height.isNotEmpty &&
          age != null &&
          age.isNotEmpty) {
        widget.onCompleted(weight, height, age, _gender);
      }
    }
  }
}
