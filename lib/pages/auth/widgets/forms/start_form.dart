import 'package:calory_calc/common/constants/constants.dart';
import 'package:calory_calc/widgets/animated/animated_items_zone/animated_items_zone.dart';
import 'package:calory_calc/widgets/widgets.dart';
import 'package:flutter/material.dart';

class StartForm extends StatefulWidget {
  StartForm({
    Key key,
    @required this.onCompleted,
  }) : super(key: key);

  final Function() onCompleted;

  @override
  _StartFormState createState() => _StartFormState();
}

class _StartFormState extends State<StartForm> {
  bool animated = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          AnimatedZone(
            animated: animated,
          ),
          Column(
            children: [
              Text(
                Constants.appName.toUpperCase(),
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
    setState(() {
      animated = false;
    });
    widget.onCompleted();
  }
}
