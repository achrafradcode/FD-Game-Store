part of intro;

class _GetStartedButton extends GetView<IntroController> {
  const _GetStartedButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 2), () {
      controller.goToDashboard();
    });
    return Container();
  }
}
