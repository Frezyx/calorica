import 'dart:async';
import 'dart:math';

import 'package:firebase_admob/firebase_admob.dart';

import 'package:calory_calc/config/adMobConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_native_admob/native_admob_options.dart';

class AdmobService {
  AdmobService._();

  final Random _rnd = Random();

  int _interstitialAdViewCount = 0;

  Duration _time;
  Timer _timer;

  static AdmobService _service;
  static AdmobService get instance {
    if (_service == null) {
      _service = AdmobService._();
    }
    return _service;
  }

  static const String TEST_DEVICE_ID = 'MobileId';

  MobileAdTargetingInfo _targetingInfo = MobileAdTargetingInfo(
    nonPersonalizedAds: false,
    keywords: <String>[
      'calorie',
      'fitness',
      'health',
      'sport',
      'фитнес',
      'калории',
      'калькулятор калорий',
      'sports',
      'eat',
      'health'
    ],
  );

  void initializePeriodically() {
    if (_interstitialAdViewCount >= 2) {
      return;
    }
    if (_interstitialAdViewCount == 0) {
      _time = Duration(seconds: 40 + _rnd.nextInt(80 - 40));
    } else {
      _time = Duration(seconds: 60 + _rnd.nextInt(140 - 60));
    }
    _timer = Timer.periodic(
      _time,
      (Timer timer) {
        _interstitialAdViewCount += 1;
        createInterstitialAd()
          ..load()
          ..show();

        timer?.cancel();
        _timer?.cancel();
        _timer = null;
        initializePeriodically();
      },
    );
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: AdMobConfig.AD_UNIT_ID_ONE,
      targetingInfo: _targetingInfo,
      listener: (MobileAdEvent event) {
        print(event);
      },
    );
  }

  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: AdMobConfig.AD_UNIT_ID_SECOND,
        size: AdSize.banner,
        targetingInfo: _targetingInfo,
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
