import 'package:calorica/blocs/auth_bloc/bloc.dart';
import 'package:calorica/screens/auth/auth.dart';
import 'package:calorica/screens/common/loader_screen.dart';
import 'package:calorica/screens/home/home.dart';
import 'package:calorica/screens/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LaunchNavigator extends StatelessWidget {
  const LaunchNavigator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return Home();
        } else if (state is Unauthenticated) {
          if (state.isFirstLaunch) {
            return OnboardingScreen();
          }
          return AuthScreen();
        }
        return LoaderScreen();
      },
    );
  }
}
