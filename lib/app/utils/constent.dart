import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:applovin_max/applovin_max.dart';
import 'package:flutter/material.dart';
import 'package:gameanalytics_sdk/gameanalytics.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' as rootBundle;

final jsonFile = "assets/gameLiens.json";

Function(String) onSearch = (p0) {};
Function() onInit = () {};
Function() onInit2 = () {};

var GamesList = {};
bool onInitiated = false;
bool isInitiated = false;

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/counter.txt');
}

Future<String> readFromAsset(String textasset) async {
  String text = await rootBundle.rootBundle.loadString(textasset);
  return text;
}

Future<String> readCounter() async {
  try {
    final file = await _localFile;

    // Read the file
    final contents = await file.readAsString();

    return contents;
  } catch (e) {
    // If encountering an error, return 0
    return "";
  }
}

void getGamesList(Function(dynamic GameList) callback) {
  if (!onInitiated) {
    final json = readFromAsset(jsonFile);
    json.then((value) {
      GamesList = jsonDecode(value);
      print(GamesList['games'][0]['name']);
      isInitiated = true;
      callback(GamesList);
    });
    onInitiated = true;
    return;
  }
  callback(GamesList);
}

final String _interstitial_ad_unit_id =
    Platform.isAndroid ? "c9c5427bbbe99b02" : "0ec0b6df498be207";

var _interstitialRetryAttempt = 0;

void initializeInterstitialAds() {
  AppLovinMAX.setInterstitialListener(InterstitialListener(
    onAdLoadedCallback: (ad) {
      // Interstitial ad is ready to be shown. AppLovinMAX.isInterstitialReady(_interstitial_ad_unit_id) will now return 'true'
      print('Interstitial ad loaded from ' + ad.networkName);
      GameAnalytics.addAdEvent({
        "adAction": GAAdAction.Loaded,
        "adType": GAAdType.Interstitial,
        "adSdkName": "apploving",
        "adPlacement": ""
      });

      // Reset retry attempt
      _interstitialRetryAttempt = 0;
    },
    onAdLoadFailedCallback: (adUnitId, error) {
      // Interstitial ad failed to load
      // We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds)
      _interstitialRetryAttempt = _interstitialRetryAttempt + 1;

      int retryDelay = pow(2, min(6, _interstitialRetryAttempt)).toInt();

      print('Apploving Interstitial ad failed to load with code ' +
          error.code.toString() +
          ' - retrying in ' +
          retryDelay.toString() +
          's');

      Future.delayed(Duration(milliseconds: retryDelay * 1000), () {
        AppLovinMAX.loadInterstitial(_interstitial_ad_unit_id);
      });
    },
    onAdDisplayedCallback: (ad) {},
    onAdDisplayFailedCallback: (ad, error) {},
    onAdClickedCallback: (ad) {},
    onAdHiddenCallback: (ad) {},
  ));
  AppLovinMAX.loadInterstitial(_interstitial_ad_unit_id);
}

bool isshowInterstitial = true;
bool isBannerLoaded = false;

Future<void> showInterstitial() async {
  // Load the first interstitial

  bool isReady =
      (await AppLovinMAX.isInterstitialReady(_interstitial_ad_unit_id))!;

  if (isReady) {
    AppLovinMAX.showInterstitial(_interstitial_ad_unit_id);
    print("Inter Showing Apploving");
    GameAnalytics.addAdEvent({
      "adAction": GAAdAction.Show,
      "adType": GAAdType.Interstitial,
      "adSdkName": "apploving",
      "adPlacement": ""
    });
  }
}

final String banner_ad_unit_id =
    Platform.isAndroid ? "ae47d56064f332cb" : "edaa95901b17188c";

void initializeBannerAds() {
  // Banners are automatically sized to 320x50 on phones and 728x90 on tablets
  AppLovinMAX.setBannerListener(AdViewAdListener(
    onAdLoadedCallback: (ad) {
      isBannerLoaded = true;
      GameAnalytics.addAdEvent({
        "adAction": GAAdAction.Loaded,
        "adType": GAAdType.Banner,
        "adSdkName": "apploving",
        "adPlacement": ""
      });
    },
    onAdLoadFailedCallback: (adUnitId, error) {},
    onAdClickedCallback: (ad) {},
    onAdExpandedCallback: (ad) {},
    onAdCollapsedCallback: (ad) {},
  ));
  AppLovinMAX.createBanner(banner_ad_unit_id, AdViewPosition.bottomCenter);
  print("Init Banner Apploving");
}

void showBanner() {
  AppLovinMAX.showBanner(banner_ad_unit_id);
  print("Show Banner Apploving");
  GameAnalytics.addAdEvent({
    "adAction": GAAdAction.Show,
    "adType": GAAdType.Banner,
    "adSdkName": "apploving",
    "adPlacement": ""
  });
}

void hideBanner() {
  AppLovinMAX.hideBanner(banner_ad_unit_id);
}
