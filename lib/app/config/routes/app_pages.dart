library routes;

import 'package:cool_math_games/app/features/dashboard/index/views/screens/dashboard_screen.dart';
import 'package:cool_math_games/app/features/intro/index/views/screens/intro_screen.dart';
import 'package:cool_math_games/app/features/product/detail/views/screens/product_detail_screen.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = _Paths.intro;
  static final pages = [
    GetPage(
      name: _Paths.intro,
      page: () => IntroScreen(),
      binding: IntroBinding(),
    ),
    GetPage(
      name: _Paths.dashboard,
      page: () => DashboardScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.productDetail,
      page: () => ProductDetailScreen(),
      binding: ProductDetailBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Paths.productGame,
      page: () => GameView(),
      binding: GameViewBinding(),
      transition: Transition.downToUp,
    ),
  ];
}
