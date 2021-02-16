import 'package:flutter/material.dart';
import 'package:calorica/widgets/launch_navigator/launch_navigator.dart';
import 'package:calorica/common/theme/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calorica',
      theme: lightTheme,
      home: LaunchNavigator(),
    );
  }
}
