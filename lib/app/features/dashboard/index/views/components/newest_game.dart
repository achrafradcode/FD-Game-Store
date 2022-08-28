part of dashboard;

String searchPreffix = "";

class _NewestGame extends GetView<DashboardController> {
  _NewestGame({Key? key, required this.theKey}) : super(key: key);

  var theKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(),
        SizedBox(height: 10),
        contentNewstGames(dashboardController: controller),
      ],
    );
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Text(
        "All Games",
        style: Theme.of(Get.context!).textTheme.headline6,
      ),
    );
  }
}

class contentNewstGames extends StatefulWidget {
  DashboardController dashboardController;
  contentNewstGames({Key? key, required this.dashboardController})
      : super(key: key);

  @override
  State<contentNewstGames> createState() =>
      _contentNewstGamesState(controller: dashboardController);
}

class _contentNewstGamesState extends State<contentNewstGames> {
  DashboardController controller;
  bool searchDelay = false;
  _contentNewstGamesState({required this.controller});

  @override
  Widget build(BuildContext context) {
    onSearch = (p0) {
      searchPreffix = p0;
      if (!searchDelay) {
        searchDelay = true;
        Timer(Duration(seconds: 2), () {
          searchDelay = false;
          setState(() {
            print('Search : ' + searchPreffix);
          });
        });
        setState(() {
          print('Search : ' + searchPreffix);
        });
      }
    };
    onInit2 = () {
      setState(() {});
    };
    return Column(
      children: [..._content()],
    );
  }

  int getListCount() {
    if (isInitiated) {
      return GamesList['games'].length;
    }
    return 0;
  }

  List<Widget> _content() {
    var index = 0;
    if (!isInitiated) {
      return <Widget>[];
    }
    var filterGames = (GamesList['games'] as List<dynamic>).where((element) {
      var flag = (element['name'] as String)
          .toLowerCase()
          .contains(searchPreffix.toLowerCase());
      print((element['name'] as String) + " : " + flag.toString());
      return flag;
    }).toList();
    return filterGames.map((p) {
      var product = new Product(
          id: index,
          iconImage: AssetImage(p['imgurl']),
          backgroundImage: AssetImage(p['imgurl']),
          screenshotImages: (p['scrs'] as List<dynamic>).map((e) {
            return AssetImage(e);
          }).toList(),
          name: p['name'],
          category: "",
          description: p['des'],
          instruction: p['inst'],
          url: p['url'],
          rating: p['rating'],
          totalDownload: 0,
          totalReview: 0);
      index++;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Hero(
          tag: controller.getNewestGameTag(product),
          child: CardProduct(
            data: CardProductData(
                image: product.iconImage,
                name: product.name,
                category: product.category,
                rating: product.rating),
            onPlay: () {
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
                parameters: {'GameView': controller.getNewestGameTag(product)},
              );
            },
            onPressed: () => controller.goToDetail(
              product,
              heroTag: controller.getNewestGameTag(product),
            ),
          ),
        ),
      );
    }).toList();
  }
}
