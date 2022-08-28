part of product_detail;

class ProductDetailController extends GetxController {
  late final Product product;
  String? heroTag;

  @override
  void onInit() {
    super.onInit();
    heroTag = Get.parameters['hero_tag'];

    product = Get.arguments as Product;
  }

  void goToDetail(Product product, {required String heroTag}) {
    if (!isshowInterstitial) {
      Timer(Duration(seconds: 30), () {
        isshowInterstitial = false;
      });
      isshowInterstitial = true;
    }
    showInterstitial();
    Get.toNamed(
      Routes.productGame,
      arguments: product,
      parameters: {'hero_tag': "$heroTag"},
    );
  }

  String getPopularGameTag(Product product) {
    return "GameView=${product.id}";
  }
}

class GameViewController extends GetxController {
  late final Product product;
  String? heroTag;

  @override
  void onInit() {
    super.onInit();
    heroTag = Get.parameters['hero_tag'];

    product = Get.arguments as Product;
  }
}
