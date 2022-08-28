library intro;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cool_math_games/app/config/routes/app_pages.dart';
import 'package:cool_math_games/app/constans/app_constants.dart';
import 'package:get/get.dart';
import 'package:cool_math_games/app/utils/ui/ui_utils.dart';
import 'package:lottie/lottie.dart';

// bindings
part '../../bindings/intro_binding.dart';

// controller
part '../../controllers/intro_controller.dart';

// component
part '../components/background_image.dart';
part '../components/get_started_button.dart';
part '../components/header_text.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          _BackgroundImage(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // _HeaderText(),
                // Spacer(flex: 3),
                _GetStartedButton(),
                // Spacer(flex: 5),
              ],
            ),
          ),
          IgnorePointer(
            child: LottieBuilder.asset(
              ImageAnimation.confetti,
              repeat: false,
            ),
          )
        ],
      ),
    );
  }
}
