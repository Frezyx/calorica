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
      backgroundColor: Colors.black,
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
                color: Colors.grey[100],
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
                    Text(
                      'Вход в аккаунт',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    AuthButton(
                      title: 'Вход с Google',
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
                    SizedBox(
                      height: 20,
                    ),
                    AuthButton(
                      title: 'Вход с Apple',
                      titleStyle: TextStyle(
                        color: theme.brightness == Brightness.light
                            ? CustomTheme.lightColor
                            : CustomTheme.darkColor,
                      ),
                      logoPath: theme.brightness == Brightness.light
                          ? Assets.appleLightLogo
                          : Assets.appleDarkLogo,
                      color: theme.brightness == Brightness.light
                          ? CustomTheme.darkColor
                          : CustomTheme.lightColor,
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
