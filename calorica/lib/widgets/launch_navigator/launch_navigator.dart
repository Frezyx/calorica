import 'package:calorica/blocs/auth_bloc/bloc.dart';
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
          return Scaffold(
            body: Text('Authenticated'),
          );
        } else if (state is Unauthenticated) {
          if (state.isFirstLaunch) {
            return Scaffold(
              body: Text('First launch'),
            );
          }
          return Scaffold(
            body: Text('Unauthenticated'),
          );
        }
        return Scaffold(
          body: Text('Loading...'),
        );
      },
    );
  }
}
