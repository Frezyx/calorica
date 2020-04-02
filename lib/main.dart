import 'package:flutter/material.dart';
import 'package:calory_calc/design/theme.dart';

import 'package:calory_calc/pages/auth.dart';
import 'package:calory_calc/pages/home.dart';

import 'package:shared_preferences/shared_preferences.dart';

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
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: DesignTheme.bgColor,
        fontFamily: 'Montserrat',
        primaryColor: DesignTheme.mainColor,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: banner? '/auth' : '/',
      routes: {
        '/auth': (BuildContext context) => AuthPage(prefs: prefs,),
        '/' : (BuildContext context) => Home(),
      },
    );
  }
}
