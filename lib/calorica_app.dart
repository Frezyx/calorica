import 'package:calory_calc/blocs/auth/bloc.dart';
import 'package:calory_calc/common/theme/theme.dart';
import 'package:calory_calc/pages/addedProduct.dart';
import 'package:calory_calc/pages/edit/choiceDiet.dart';
import 'package:calory_calc/pages/edit/editUser.dart';
import 'package:calory_calc/pages/edit/editUserDietParams.dart';
import 'package:calory_calc/pages/edit/editUserParams.dart';
import 'package:calory_calc/widgets/navigator/navigator.dart';
import 'package:flutter/material.dart';

import 'package:calory_calc/pages/product/products_list.dart';
import 'package:calory_calc/pages/auth/auth.dart';
import 'package:calory_calc/pages/product.dart';
import 'package:calory_calc/pages/stats/daydata.dart';
import 'package:calory_calc/pages/stats/history.dart';
import 'package:calory_calc/pages/stats/mainStats.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/constants/constants.dart';
import 'pages/launch_navigator.dart';

class CaloricaApp extends StatefulWidget {
  @override
  _CaloricaAppState createState() => _CaloricaAppState();
}

class _CaloricaAppState extends State<CaloricaApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) {
            return AuthBloc()..add(LoadAuthorization());
          },
        ),
      ],
      child: MaterialApp(
        title: Constants.appName,
        theme: lightTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: '/launch',
        routes: {
          '/homePage': (BuildContext context) => NavigatorPage(index: 1),
          '/launch': (BuildContext context) => LaunchNavigator(),
          '/add': (BuildContext context) => AddPage(),
          '/stats': (BuildContext context) => MainStats(),
          '/history': (BuildContext context) => HistoryPage(),
          '/editUser': (BuildContext context) => EditUserPage(),
          '/editUserParams': (BuildContext context) => EditUserParamsPage(),
          '/editUserDietParams': (BuildContext context) => EditDietParamsPage(),
          '/choiseDiet': (BuildContext context) => ChoiseDietPage(),
        },
        onGenerateRoute: (RouteSettings) {
          var path = RouteSettings.name.split('/');

          if (path[1] == 'product') {
            return MaterialPageRoute(
                builder: (context) => ProductPage(id: path[2]),
                settings: RouteSettings);
          }

          if (path[1] == 'navigator') {
            return MaterialPageRoute(
                builder: (context) => NavigatorPage(index: int.parse(path[2])),
                settings: RouteSettings);
          }

          if (path[1] == 'daydata') {
            return MaterialPageRoute(
                builder: (context) => DayDatePage(date: path[2]),
                settings: RouteSettings);
          }

          if (path[1] == 'addedProduct') {
            return MaterialPageRoute(
                builder: (context) =>
                    AddedProductPage(id: path[2], from: path[3]),
                settings: RouteSettings);
          }
        },
      ),
    );
  }
}
