library product_detail;

import 'dart:async';
import 'dart:io';

import 'package:applovin_max/applovin_max.dart';
import 'package:cool_math_games/app/utils/constent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:cool_math_games/app/config/routes/app_pages.dart';
import 'package:cool_math_games/app/constans/app_constants.dart';
import 'package:cool_math_games/app/features/product/detail/views/components/gameSection.dart';
import 'package:cool_math_games/app/shared_components/rating_icon.dart';
import 'package:cool_math_games/app/utils/services/rest_api_service.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:cool_math_games/app/utils/ui/ui_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webviewx/webviewx.dart';
import 'package:flutter_test/flutter_test.dart';

// binding
part '../../bindings/product_detail_binding.dart';

// controller
part '../../controllers/product_detail_controller.dart';

// component
part '../components/back_button.dart';
part '../components/background_image.dart';
part '../components/description.dart';
part '../components/header.dart';
part '../components/install_button.dart';
part '../components/rating_and_review.dart';
part '../components/screenshot_image.dart';

final _key = GlobalKey();
final Function() onDispose = () {};

class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            _BackgroundImage(),
            Container(
              margin: EdgeInsets.only(
                  top: _BackgroundImage.height - (_BackgroundImage.height / 2)),
              decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  _Header(),
                  // SizedBox(height: 20),
                  // GameSection(
                  //   globalKey: _key,
                  // )
                  SizedBox(height: 20),
                  _ScreenshotImage(),
                  SizedBox(height: 20),
                  _Description(),
                  SizedBox(height: 20),
                  _RatingsAndReview(),
                  // SizedBox(height: 20),
                ],
              ),
            ),
            BackButton(),
          ],
        ),
      ),
      bottomNavigationBar: _InstallButton(),
    );
  }
}

class GameView extends GetView<GameViewController> {
  GameView({Key? key}) : super(key: key);

  Widget widget = Column();

  @override
  Widget build(BuildContext context) {
    String embededUrl = this.controller.product.url;
    String cent =
        '<script>var frame = document.getElementById("html5game");console.log(frame);</script> <style>html{border: none;height: 100%;width: 100%;}body{border: none;height: 100%;width: 100%;margin: 0px;}</style><iframe id="html5game" src="$embededUrl" class="square no-select" style="width:100%;height:100%;" scrolling="no" marginwidth="0" vspace="0" frameborder="0" hspace="0" marginheight="0" sandbox="allow-downloads allow-forms allow-modals allow-orientation-lock allow-pointer-lock allow-popups allow-popups-to-escape-sandbox allow-presentation allow-same-origin allow-scripts"></iframe>';
    cent = embededUrl;
    // onDispose = webViewXController.dispose;

    // Timer(Duration(milliseconds: 10), () {
    //   widget = WebViewX(
    //     initialSourceType: SourceType.html,
    //     width: context.width,
    //     height: context.height,
    //     onWebViewCreated: (controller) {
    //       webViewXController = controller;
    //       webViewXController.loadContent(cent, SourceType.html);
    //       webViewXControllerIsInitialized = true;
    //     },
    //   );

    // });

    return Scaffold(
        key: _key,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 35,
        ),
        body: Stack(children: [
          WebViewX(
            initialSourceType: SourceType.url,
            width: context.width,
            height: context.height,
            onWebViewCreated: (controller) {
              webViewXController = controller;
              webViewXController.loadContent(cent, SourceType.url);
              // webViewXController.callJsMethod(name, params)

              webViewXControllerIsInitialized = true;
            },
          ),
        ]));
  }

  Future<bool> sendKeyDownEvent(LogicalKeyboardKey key,
      {String? character}) async {
    String platform = "android";
    if (Platform.isAndroid) {
      platform = "android";
    } else if (Platform.isWindows) {
      platform = "windows";
    }
    print(platform);
    assert(platform != null);
    // Internally wrapped in async guard.
    return simulateKeyDownEvent(key, character: character, platform: platform);
  }
}
