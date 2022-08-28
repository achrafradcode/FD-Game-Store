part of product_detail;

class _InstallButton extends GetView<ProductDetailController> {
  const _InstallButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: kDefaultPadding,
        right: kDefaultPadding,
        top: kDefaultPadding / 2,
        bottom: isBannerLoaded ? 90 : kDefaultPadding / 2,
      ),
      child: ElevatedButton(
              onPressed: () => controller.goToDetail(
                    controller.product,
                    heroTag: controller.getPopularGameTag(controller.product),
                  ),
              child: Text("Play"))
          .large(),
    );
  }
}
