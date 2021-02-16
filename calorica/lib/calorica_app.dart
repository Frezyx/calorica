import 'package:calorica/widgets/launch_navigator/launch_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'blocs/auth_bloc/auth_bloc.dart';
import 'blocs/auth_bloc/auth_event.dart';
import 'common/theme/theme_data/light_theme.dart';

class CaloricaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) {
            return AuthBloc()..add(Login());
          },
        ),
      ],
      child: MaterialApp(
        title: 'Calorica',
        theme: lightTheme.copyWith(
          textTheme: GoogleFonts.rubikTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: LaunchNavigator(),
      ),
    );
  }
}
