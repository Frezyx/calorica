import 'package:calory_calc/pages/addedProduct.dart';
import 'package:calory_calc/pages/authLastPage.dart';
import 'package:calory_calc/pages/authSecondScreen.dart';
import 'package:calory_calc/pages/editUser.dart';
import 'package:calory_calc/widgets/navigator/navigator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/pages/add.dart';
import 'package:calory_calc/pages/auth.dart';
import 'package:calory_calc/pages/home.dart';
import 'package:calory_calc/pages/product.dart';
import 'package:calory_calc/pages/stats/daydata.dart';
import 'package:calory_calc/pages/stats/history.dart';
import 'package:calory_calc/pages/stats/mainStats.dart';

StatefulWidget getRegisterPage(SharedPreferences prefs){
  return AuthPage(prefs: prefs);
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();  
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool banner = (prefs.getBool('banner') ?? true);

  runApp(
       MyApp(banner: banner, prefs: prefs,),
    );
}

class MyApp extends StatefulWidget {

  MyApp({bool banner,SharedPreferences prefs}): _banner = banner, _prefs = prefs;
  bool _banner;
  SharedPreferences _prefs;

  @override
  _MyAppState createState() => _MyAppState(_banner, _prefs);
}

class _MyAppState extends State<MyApp> {

  _MyAppState(this.banner, this.prefs);
  bool banner;
  SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calori Calc',
      theme: ThemeData(
        backgroundColor: DesignTheme.bgColor,
        fontFamily: 'Montserrat',
        accentColor: DesignTheme.mainColor,
        primaryColorDark: DesignTheme.secondColor,
        primaryColorLight: DesignTheme.mainColor,
        primaryColor: DesignTheme.mainColor,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: banner? '/auth' : '/navigator/1',
      routes: {
        '/auth': (BuildContext context) => AuthPage(prefs: prefs,),
        '/add' : (BuildContext context) => AddPage(),
        '/stats' : (BuildContext context) => MainStats(),
        '/history' : (BuildContext context) => HistoryPage(),
        '/authSecondScreen': (BuildContext context) => SecondAuthPage(),
        '/selectActiviti' : (BuildContext context) => ActivitiSelectPage(),
        '/editUser' : (BuildContext context) => EditUserPage(),
      },

      onGenerateRoute: (RouteSettings){
        var path = RouteSettings.name.split('/');

        if(path[1] == 'product'){
          return new MaterialPageRoute(builder: (context) => new ProductPage(id:path[2]),
          settings: RouteSettings);
        }

        if(path[1] == 'navigator'){
          return new MaterialPageRoute(builder: (context) => new NavigatorPage(index:int.parse(path[2])),
          settings: RouteSettings);
        }

        if(path[1] == 'daydata'){
          return new MaterialPageRoute(builder: (context) => new DayDatePage(date:path[2]),
          settings: RouteSettings);
        }

        if(path[1] == 'addedProduct'){
          return new MaterialPageRoute(builder: (context) => new AddedProductPage(id:path[2], from:path[3]),
          settings: RouteSettings);
        }

      }

    );
  }
}
