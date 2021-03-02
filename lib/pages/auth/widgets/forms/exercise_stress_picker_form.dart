import 'package:calory_calc/common/theme/theme.dart';
import 'package:calory_calc/widgets/customRadio.dart';
import 'package:calory_calc/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ExerciseStressPickerForm extends StatefulWidget {
  const ExerciseStressPickerForm({
    Key key,
    @required this.onComplete,
  }) : super(key: key);

  final Function(double workModel) onComplete;

  @override
  _ExerciseStressPickerFormState createState() =>
      _ExerciseStressPickerFormState();
}

class _ExerciseStressPickerFormState extends State<ExerciseStressPickerForm> {
  double selectedWorkModel;

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
                'Физическая активность',
                style: CustomTheme.subtitle.copyWith(
                  color: theme.primaryColor,
                ),
              ),
            ],
          ),
          CustomRadio(
            onSelect: (double workModel) {
              setState(() {
                selectedWorkModel = workModel;
              });
            },
          ),
          CommonButton(
            child: Text(
              'Далее',
              style: Theme.of(context).textTheme.button.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            onPressed: () => widget.onComplete(selectedWorkModel),
          ),
        ],
      ),
    );
  }
}
