part of intro;

class _BackgroundImage extends StatelessWidget {
  const _BackgroundImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
            alignment: Alignment.center,
            child: Image(
                fit: BoxFit.fill,
                width: context.width,
                image: AssetImage(ImageVector.backgroundLiquid))),
      ],
    );
  }
}
