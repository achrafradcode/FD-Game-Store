import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cool_math_games/app/config/routes/app_pages.dart';
import 'package:cool_math_games/app/config/themes/app_theme.dart';
import 'package:gameanalytics_sdk/gameanalytics.dart';
import 'package:get/get.dart';
import 'package:applovin_max/applovin_max.dart';

import 'app/utils/constent.dart';

Map? sdkConfiguration;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    getGamesList((callback) {
      Timer(Duration(milliseconds: 1000), () {
        onInit();
        onInit2();
        initAds().then((value) {
          initializeBannerAds();
          initializeInterstitialAds();
          print("Init SDK");
        });
      });
    });
    Timer(Duration(seconds: 30), () {
      isshowInterstitial = false;
    });
    GameAnalytics.setEnabledInfoLog(true);
    GameAnalytics.setEnabledVerboseLog(true);

    GameAnalytics.configureBuild("0.1.0");
    GameAnalytics.configureAutoDetectAppVersion(true);
    GameAnalytics.initialize("d4819171ecffe8fe0d3237bacb907a5f",
        "a3a361f7488a1f54b504770e2837d98baad852f6");
    return GetMaterialApp(
      title: 'Game Store',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.basic,
      initialRoute: AppPages.initial,
      getPages: AppPages.pages,
    );
  }
}

Future<void> initAds() async {
  sdkConfiguration = await AppLovinMAX.initialize(
      "zEt4_M4PkG_cNWU_sR4p4RXZ6mE5AO4RAx8SQs1BVTZR5iMfLP54K_p1L4C6x88exH8F__Tr3QQ0TgrAyzCiPq");
}
