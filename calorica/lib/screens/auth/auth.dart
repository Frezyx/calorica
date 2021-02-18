import 'package:calorica/common/constants/assets/assets.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: Stack(
        children: [
          Opacity(
            opacity: 0.7,
            child: Image(
              width: size.width,
              image: AssetImage(Assets.background),
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            
          ),
        ],
      ),
    );
  }
}
