import 'package:calory_calc/models/dbModels.dart';
import 'package:calory_calc/utils/databaseHelper.dart';
import 'package:firebase_admob/firebase_admob.dart';

const String testDevice = 'MobileId';

  MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['Game', 'Mario'],
  );

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
        adUnitId: "ca-app-pub-6210480653379985/2893338919",
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("IntersttialAd -------------------------------------------->$event");
        });
  }

    BannerAd createBannerAd() {

    return BannerAd(
        adUnitId: "ca-app-pub-6210480653379985/8288942306",
      //Change BannerAd adUnitId with Admob ID
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd -----------------------------------> $event");
        });
  }

addClick(){
    DBUserProvider.db.counter().then((condition){
      if(condition){
        createInterstitialAd()
          ..load()
          ..show();
      }
    });
}