import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/common/theme/theme.dart';
import 'package:calory_calc/models/dbModels.dart';
import 'package:calory_calc/providers/local_providers/userProvider.dart';
import 'package:calory_calc/utils/convertors/workModelFromTxt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserParamsForm extends StatefulWidget {
  @override
  _UserParamsFormState createState() => _UserParamsFormState();
}

class _UserParamsFormState extends State<UserParamsForm> {
  User user = User();

  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String dropdownValue = "";

  @override
  void initState() {
    DBUserProvider.db.getUser().then((_user) {
      setState(() {
        user = _user;
        _weightController.text = user.weight.toString();
        _heightController.text = user.height.toString();
        _ageController.text = user.age.toString();
        dropdownValue = user.workModel == 1.2
            ? 'Минимум физической активности'
            : user.workModel == 1.375
                ? 'Занимаюсь спортом 1-3 раза в неделю'
                : user.workModel == 1.55
                    ? 'Занимаюсь спортом 3-4 раза в неделю'
                    : user.workModel == 1.7
                        ? 'Занимаюсь спортом каждый день'
                        : 'Тренируюсь по несколько раз в день';
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
