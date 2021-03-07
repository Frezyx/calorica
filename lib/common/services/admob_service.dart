import 'package:firebase_admob/firebase_admob.dart';

import 'package:calory_calc/config/adMobConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_native_admob/native_admob_options.dart';

class AdmobService {
  AdmobService._();

  static AdmobService _service;
  static AdmobService get instance {
    if (_service == null) {
      _service = AdmobService._();
    }
    return _service;
  }

  static const String TEST_DEVICE_ID = 'MobileId';

  MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    nonPersonalizedAds: true,
    keywords: <String>['calorie', 'fitness', 'health', 'sport'],
  );

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: AdMobConfig.AD_UNIT_ID_ONE,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print(event);
      },
    );
  }

  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: AdMobConfig.AD_UNIT_ID_SECOND,
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {});
  }

  getAdBigBlock() {
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

  getAdMidleBlock() {
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

  getAdMobGraphBaner(context) {
    final _controller = NativeAdmobController();

    return Container(
      height: 120,
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

  Widget buildListViewItem() {
    final _controller = NativeAdmobController();

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
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
}
