library dashboard;

import 'dart:async';
import 'dart:ui';

import 'package:applovin_max/applovin_max.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cool_math_games/app/config/routes/app_pages.dart';
import 'package:cool_math_games/app/constans/app_constants.dart';
import 'package:cool_math_games/app/shared_components/card_image.dart';
import 'package:cool_math_games/app/shared_components/card_product.dart';
import 'package:cool_math_games/app/shared_components/custom_icon_button.dart';
import 'package:cool_math_games/app/utils/constent.dart';
import 'package:cool_math_games/app/utils/services/rest_api_service.dart';
import 'package:get/get.dart';

// bindings
part '../../bindings/dashboard_binding.dart';

// controllers
part '../../controllers/dashboard_controller.dart';

// components
part '../components/background_content.dart';
part '../components/background_image.dart';
part '../components/bottom_navbar.dart';
part '../components/category_buttons.dart';
part '../components/header.dart';
part '../components/newest_game.dart';
part '../components/popular_game.dart';
part '../components/search_text_field.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({Key? key}) : super(key: key);

  final _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 1), () {
      i(isSDKInitiated){
        initializeBannerAds();
        showBanner();
      }

    });
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: _key,
      body: Stack(
        children: [
          _BackgroundImage(),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(height: 50),
                _Header(),
                SizedBox(height: 30),
                _SearchTextField(),
                SizedBox(height: 30),
                _BackgroundContent(
                  child: Column(
                    children: [
                      // SizedBox(height: 30),
                      // _CategoryButtons(),
                      SizedBox(height: 30),
                      _PopularGame(theKey: _key),
                      SizedBox(height: 30),
                      _NewestGame(
                        theKey: _key,
                      ),
                      // SizedBox(height: 30),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: isBannerLoaded ? 90 : 0,
        child: MaxAdView(
            adFormat: AdFormat.banner,
            adUnitId: banner_ad_unit_id,
            listener: AdViewAdListener(
                onAdLoadedCallback: (ad) {
                  print("Banner AdLoaded");
                },
                onAdLoadFailedCallback: (adUnitId, error) {
                  print(error);
                },
                onAdClickedCallback: (ad) {},
                onAdExpandedCallback: (ad) {},
                onAdCollapsedCallback: (ad) {})),
      ),
    );
  }
}
