import 'package:calorica/common/constants/assets/assets.dart';
import 'package:calorica/common/theme/custom_theme.dart';
import 'package:calorica/widgets/common/buttons/auth_button.dart';
import 'package:calorica/widgets/common/buttons/custom_raised_button.dart';
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: size.width,
              height: size.height * 0.88,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AuthButton(
                      title: 'Вход через Google',
                      titleStyle: TextStyle(
                        color: theme.brightness == Brightness.light
                            ? CustomTheme.darkColor
                            : CustomTheme.lightColor,
                      ),
                      logoPath: Assets.googleLogo,
                      color: theme.brightness == Brightness.light
                          ? CustomTheme.lightColor
                          : CustomTheme.darkColor,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
