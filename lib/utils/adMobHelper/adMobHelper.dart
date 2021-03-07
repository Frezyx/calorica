import 'package:calory_calc/common/theme/custom_theme/custom_theme.dart';
import 'package:calory_calc/config/adMobConfig.dart';
import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/common/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_native_admob/native_admob_options.dart';

class AdMobHelper {
  static getAdBigBlock() {
    final _controller = NativeAdmobController();
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 1.0,
      child: Container(
        height: 250,
        child: NativeAdmob(
          adUnitID: AdMobConfig.NATIVE_ADMOB_BIG_BLOCK_ID,
          controller: _controller,
        ),
      ),
    );
  }

  static getAdMidleBlock() {
    final _controller = NativeAdmobController();
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 1.0,
      child: Container(
        height: 150,
        child: NativeAdmob(
          adUnitID: AdMobConfig.NATIVE_ADMOB_BIG_BLOCK_ID,
          controller: _controller,
        ),
      ),
    );
  }

  static getAdMobGraphBaner(context) {
    final _controller = NativeAdmobController();

    return Container(
      height: 170,
      color: Colors.white,
      child: NativeAdmob(
        options: NativeAdmobOptions(
          showMediaContent: true,
        ),
        type: NativeAdmobType.banner,
        adUnitID: AdMobConfig.NATIVE_ADMOB_GRAPH_BLOCK_ID,
        controller: _controller,
      ),
    );
  }
}
