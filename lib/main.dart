import 'package:calory_calc/config/adMobConfig.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

import 'calorica_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseAdMob.instance.initialize(appId: AdMobConfig.APP_ID);
  runApp(CaloricaApp());
}
