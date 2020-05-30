import 'package:flutter/material.dart';
import 'app.dart';

class HomeScreen extends StatelessWidget {
  final List<Supply> supplies = [
    Supply(
      itemDescription: '12 loaves of bread',
      spotted: DateTime.now().subtract(Duration(minutes: 30)),
      username: 'helpful_user',
      address: '2323 Amazing Drive',
      store: Store.walmart(location: 'Union Landing'),
    ),
  ];

  Widget buildItem(BuildContext context, int index) {
    final Supply item = supplies[index];
    final TextStyle titleStyle = Theme
        .of(context)
        .textTheme
        .headline5;
    final Duration fancyTime = DateTime.now().difference(item.spotted);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                '${item.itemDescription} at ${item.store.name}',
                style: titleStyle,
              ),
              Text(
                  '${item.itemDescription} are available at ${item.store}. '
                      'Spotted $fancyTime ago by ${item.username}.'
              ),
            ],
          ),
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

  Supply({@required this.itemDescription,
    @required this.spotted,
    @required this.username,
    @required this.address,
    @required this.store,
  });
}

class Store {
  final String name;
  final String locationName;

  Store._({@required this.name, @required this.locationName});

  factory Store.walmart({@required String location})
  => Store._(name: 'Walmart', locationName: location);

  factory Store.target({@required String location})
  => Store._(name: 'Target', locationName: location);

  String toString() => '$locationName $name';
}
