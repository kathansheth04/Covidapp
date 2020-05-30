import 'package:flutter/material.dart';
import 'app.dart';

String fancyTime(Duration duration) {
  // if >=1d, round
  if (duration.inDays >= 1) {
    final int amt =
        duration.inHours % 24 >= 12 ? duration.inDays + 1 : duration.inDays;
    return '$amt day${amt > 1 ? 's' : ''}';
  }
  // ditto hours
  if (duration.inHours >= 1) {
    final int amt =
        duration.inMinutes % 60 >= 30 ? duration.inHours + 1 : duration.inHours;
    return '$amt hour${amt > 1 ? 's' : ''}';
  }
  // ditto minutes
  if (duration.inMinutes >= 1) {
    final int amt = duration.inSeconds % 60 >= 30
        ? duration.inMinutes + 1
        : duration.inMinutes;
    return '$amt minute${amt > 1 ? 's' : ''}';
  }
  // just return seconds
  final int amt = duration.inSeconds;
  return '$amt second${amt > 1 ? 's' : ''}';
}

class HomeScreen extends StatelessWidget {
  final List<Supply> supplies = [
    Supply(
      itemDescription: '12 loaves of bread',
      spotted: DateTime.now().subtract(Duration(minutes: 30)),
      username: 'helpful_user',
      address: '2323 Amazing Drive',
      store: Store.walmart(location: 'Union Landing'),
      imageURL:
          'https://lilluna.com/wp-content/uploads/2018/12/homemade-bread-resize-6-500x500.jpg',
    ),
    Supply(
      itemDescription: '3 packs of eggs',
      spotted: DateTime.now().subtract(Duration(minutes: 3)),
      username: 'random_kid123',
      address: '2555 Livermore Drive',
      store: Store.target(location: 'Livermore'),
      imageURL:
          'https://i0.wp.com/cdn-prod.medicalnewstoday.com/content/images/articles/283/283659/a-basket-of-eggs.jpg',
    ),
  ];

  Widget buildItem(BuildContext context, int index) {
    final Supply item = supplies[index];
    final TextStyle titleStyle =
        Theme.of(context).textTheme.headline5.copyWith(color: Colors.white);
    final String time = fancyTime(DateTime.now().difference(item.spotted));

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Card(
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image.network(
                  item.imageURL,
                  fit: BoxFit.fitHeight,
                  color: Colors.black.withAlpha(89 /*35%*/),
                  colorBlendMode: BlendMode.darken,
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    '${item.itemDescription} at ${item.store.name}',
                    style: titleStyle,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Text(
                '${item.itemDescription} are available at ${item.store}. '
                'Spotted $time ago by ${item.username}.',
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                FlatButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.directions),
                  label: const Text('DIRECTIONS'),
                ),
                FlatButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.info),
                  label: const Text('MORE INFO'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supplies'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        child: ListView.builder(
          itemBuilder: buildItem,
          itemCount: supplies.length,
        ),
      ),
      bottomNavigationBar: BottomTabBar(
        items: items,
        selectedIndex: 1,
      ),
    );
  }
}

class Supply {
  final String itemDescription;
  final DateTime spotted;
  final String username;
  final String address;
  final Store store;
  final String imageURL;

  Supply({
    @required this.itemDescription,
    @required this.spotted,
    @required this.username,
    @required this.address,
    @required this.store,
    @required this.imageURL,
  });
}

class Store {
  final String name;
  final String locationName;

  Store._({@required this.name, @required this.locationName});

  factory Store.walmart({@required String location}) =>
      Store._(name: 'Walmart', locationName: location);

  factory Store.target({@required String location}) =>
      Store._(name: 'Target', locationName: location);

  String toString() => '$locationName $name';
}
