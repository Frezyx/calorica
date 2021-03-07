import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/common/theme/theme.dart';
import 'package:calory_calc/models/diet.dart';
import 'package:calory_calc/providers/local_providers/dietProvider.dart';
import 'package:calory_calc/widgets/alerts/easyGoogAlert.dart';
import 'package:calory_calc/widgets/appBars/arrowBackAppBar.dart';
import 'package:calory_calc/widgets/widgets.dart';
import 'package:flutter/material.dart';

class EditDietParamsPage extends StatefulWidget {
  @override
  _EditDietParamsPageState createState() => _EditDietParamsPageState();
}

class _EditDietParamsPageState extends State<EditDietParamsPage> {
  Diet diet = Diet();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _caloryLimitController = TextEditingController();
  final TextEditingController _carbohLimitController = TextEditingController();
  final TextEditingController _squiLimitController = TextEditingController();
  final TextEditingController _fatLimitController = TextEditingController();

  @override
  void initState() {
    DBDietProvider.db.getDietById(1).then((_diet) {
      setState(() {
        diet = _diet;

        _caloryLimitController.text = diet.calory.toString();
        _carbohLimitController.text = diet.carboh.toString();
        _squiLimitController.text = diet.squi.toString();
        _fatLimitController.text = diet.fat.toString();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getArrowBackAppBar("Параметры тела", "/editUser", context),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 30, top: 30, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: _caloryLimitController,
                    cursorColor: CustomTheme.mainColor,
                    decoration: InputDecoration(
                        labelText: 'Лимит калорий',
                        labelStyle: DesignTheme.selectorLabel,
                        suffixIcon: Icon(
                          Icons.filter_1,
                        )),
                    validator: (value) {
                      if (value.isEmpty) return 'Введите лимит калорий в день';
                      if (!(double.parse(value) is double))
                        return 'Введите число';
                      else {
                        diet.calory = double.parse(value);
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _squiLimitController,
                    cursorColor: CustomTheme.mainColor,
                    decoration: InputDecoration(
                        labelText: 'Лимит белков',
                        labelStyle: DesignTheme.selectorLabel,
                        suffixIcon: Icon(
                          Icons.filter_2,
                        )),
                    validator: (value) {
                      if (value.isEmpty) return 'Введите лимит белков в день';
                      if (!(double.parse(value) is double))
                        return 'Введите число';
                      else {
                        diet.squi = double.parse(value);
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _fatLimitController,
                    cursorColor: CustomTheme.mainColor,
                    decoration: InputDecoration(
                        labelText: 'Лимит жиров',
                        labelStyle: DesignTheme.selectorLabel,
                        suffixIcon: Icon(
                          Icons.filter_3,
                        )),
                    validator: (value) {
                      if (value.isEmpty) return 'Введите лимит жиров в день';
                      if (!(double.parse(value) is double))
                        return 'Введите число';
                      else {
                        diet.fat = double.parse(value);
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _carbohLimitController,
                    cursorColor: CustomTheme.mainColor,
                    decoration: InputDecoration(
                        labelText: 'Лимит углеводов',
                        labelStyle: DesignTheme.selectorLabel,
                        suffixIcon: Icon(
                          Icons.filter_4,
                        )),
                    validator: (value) {
                      if (value.isEmpty)
                        return 'Введите лимит углеводов в день';
                      if (!(double.parse(value) is double))
                        return 'Введите число';
                      else {
                        diet.carboh = double.parse(value);
                      }
                    },
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
                bottom: 40,
              ),
              child: CommonButton(
                child: Text(
                  'Сохранить',
                  style: Theme.of(context).textTheme.button,
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    DBDietProvider.db.updateDiet(diet).then(
                      (res) {
                        if (res == 1) {
                          goodAlert(context);
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
