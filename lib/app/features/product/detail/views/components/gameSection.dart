import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:webviewx/webviewx.dart';

import '../screens/product_detail_screen.dart';

late WebViewXController webViewXController;
bool webViewXControllerIsInitialized = false;

class GameSection extends GetView<ProductDetailController> {
  GameSection({Key? key, required this.globalKey}) : super(key: key);

  GlobalKey globalKey;

  Widget widget = Column();

  @override
  Widget build(BuildContext context) {
    String embededUrl = this.controller.product.url;
    String cent =
        '<iframe id="html5game" src="$embededUrl" class="square no-select" style="width:100%;height:100%;" scrolling="no" marginwidth="0" vspace="0" frameborder="0" hspace="0" marginheight="0" sandbox="allow-scripts allow-same-origin allow-modals"></iframe>';
    cent = embededUrl;
    if (webViewXControllerIsInitialized) {
      webViewXController.dispose();
    }

    // onDispose = webViewXController.dispose;

    Timer(Duration(milliseconds: 10), () {
      widget = WebViewX(
        initialSourceType: SourceType.url,
        width: context.width,
        height: context.height,
        onWebViewCreated: (controller) {
          webViewXController = controller;
          webViewXController.loadContent(cent, SourceType.url);
          webViewXControllerIsInitialized = true;
        },
      );
    });

    return Expanded(
      child: widget,
    );
  }
}
