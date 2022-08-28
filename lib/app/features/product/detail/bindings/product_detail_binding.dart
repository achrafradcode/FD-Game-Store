part of product_detail;

class ProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductDetailController());
  }
}

class GameViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GameViewController());
  }
}
