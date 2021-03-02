import 'package:calory_calc/common/theme/constants/constants.dart';
import 'package:calory_calc/common/theme/theme.dart';
import 'package:calory_calc/widgets/animated/animated_items_zone/animated_items_zone.dart';
import 'package:calory_calc/widgets/widgets.dart';
import 'package:flutter/material.dart';

class StartForm extends StatelessWidget {
  StartForm({
    Key key,
    @required this.onCompleted,
  }) : super(key: key);

  final Function() onCompleted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          AnimatedZone(),
          Column(
            children: [
              Text(
                Conatntas.appName.toUpperCase(),
                style: TextStyle(
                  fontSize: 50,
                  color: theme.primaryColor,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                'Ваш индивидуальный помощник в вопросах диеты',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: theme.hintColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          CommonButton(
            child: Text(
              'Начать',
              style: Theme.of(context).textTheme.button.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            onPressed: () => _onButtonPressed(context),
          ),
        ],
      ),
    );
  }

  void _onButtonPressed(BuildContext context) {
    onCompleted();
  }
}
