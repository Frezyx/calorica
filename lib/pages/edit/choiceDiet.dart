import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/common/theme/theme.dart';
import 'package:calory_calc/widgets/error/errorScreens.dart';
import 'package:flutter/material.dart';

class ChoiseDietPage extends StatefulWidget {
  @override
  _ChoiseDietPageState createState() => _ChoiseDietPageState();
}

class _ChoiseDietPageState extends State<ChoiseDietPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DesignTheme.backgroundColor,
        body: Stack(children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 4,
                left: 20,
                right: 20),
            child: ErrorScreens.getOnDevelopmentScreen(context),
          )
        ]));
  }
}
