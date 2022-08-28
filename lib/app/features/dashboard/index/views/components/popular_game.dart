part of dashboard;

class _PopularGame extends GetView<DashboardController> {
  _PopularGame({Key? key, required this.theKey}) : super(key: key);

  var theKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(),
        SizedBox(height: 10),
        contentPopularGame(
          controller: controller,
        )
      ],
    );
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Text(
        "Math Games",
        style: Theme.of(Get.context!).textTheme.headline6,
      ),
    );
  }
}

class contentPopularGame extends StatefulWidget {
  DashboardController controller;
  contentPopularGame({Key? key, required this.controller}) : super(key: key);

  @override
  State<contentPopularGame> createState() =>
      _contentPopularGameState(controller: controller);
}

class _contentPopularGameState extends State<contentPopularGame> {
  DashboardController controller;
  _contentPopularGameState({required this.controller});

  @override
  Widget build(BuildContext context) {
    onInit = () {
      setState(() {});
    };
    return _content();
  }

  int getListCount() {
    if (isInitiated) {
      return 8;
    }
    return 0;
  }

  Widget _content() {
    if (!isInitiated) {
      return SizedBox(
        height: CardImage.size.height,
      );
    }
    var games = (GamesList['games'] as List<dynamic>);
    var gameList = games.getRange(games.length - 8, games.length).toList();
    gameList.shuffle();
    return SizedBox(
      height: CardImage.size.height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: getListCount(),
        itemBuilder: (context, index) {
          var product = new Product(
              id: index,
              iconImage: AssetImage(gameList[index]['imgurl']),
              backgroundImage: AssetImage(gameList[index]['imgurl']),
              screenshotImages:
                  (gameList[index]['scrs'] as List<dynamic>).map((e) {
                return AssetImage(e);
              }).toList(),
              name: gameList[index]['name'],
              instruction: gameList[index]['inst'],
              category: "",
              description: gameList[index]['des'],
              url: gameList[index]['url'],
              rating: gameList[index]['rating'],
              totalDownload: 0,
              totalReview: 0);

          return Hero(
            tag: controller.getPopularGameTag(product),
            child: CardImage(
              image: product.backgroundImage,
              onPressed: () => controller.goToDetail(
                product,
                heroTag: controller.getPopularGameTag(product),
              ),
            ),
          );
        },
      ),
    );
  }
}
