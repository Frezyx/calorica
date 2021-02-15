import 'package:firebase_admob/firebase_admob.dart';

import 'package:calory_calc/providers/local_providers/userProvider.dart';
import 'package:calory_calc/config/adMobConfig.dart';

const String testDevice = 'MobileId';

MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  testDevices: testDevice != null ? <String>[testDevice] : null,
  nonPersonalizedAds: true,
  keywords: <String>['calorie', 'fitness', 'health', 'sport'],
);

InterstitialAd createInterstitialAd() {
  return InterstitialAd(
      adUnitId: AdMobConfig.AD_UNIT_ID_ONE,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {});
}

BannerAd createBannerAd() {
  return BannerAd(
      adUnitId: AdMobConfig.AD_UNIT_ID_SECOND,
      size: AdSize.banner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {});
}

addClick() {
  DBUserProvider.db.counter().then((condition) {
    if (condition) {
      createInterstitialAd()
        ..load()
        ..show();
    }
  });
}
