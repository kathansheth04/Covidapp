import 'dart:convert';

import 'package:covidapp/src/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'app.dart';
import 'auth.dart';
import 'supplies_backend.dart';

part 'home_screen.g.dart';

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

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
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

  Stream<Supply2> _supplies;
  List<Supply2> _lSupplies = [];
  bool _hasMore = true;

  Widget buildItem(BuildContext context, Supply2 supply) {
    final Supply item = supply.supply;
    final TextStyle titleStyle =
        Theme.of(context).textTheme.headline5.copyWith(color: Colors.white);
    final String time = fancyTime(DateTime.now().difference(item.spotted));

    final Future<String> imageURLFuture = () async {
      final res = await http.get("https://?query=${item.itemDescription}");
      final r = json.decode(res.body);
      return r['results'][0]['urls']['regular'] as String;
    }();

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Card(
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image.network(
                  "https://source.unsplash.com/500x500?${Uri.encodeQueryComponent(item.itemDescription)}",
                  fit: BoxFit.fitHeight,
                  color: Colors.black.withAlpha(89 /* 35%*/),
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
                  onPressed: () {
                    openMap(item.address);
                  },
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
  void initState() {
    super.initState();
    _supplies = listSupplies();
    _supplies.listen(
      (item) => setState(() {
        _lSupplies.add(item);
      }),
      onDone: () => setState(() {
        _hasMore = false;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final BaseAuth auth = Provider.of(context);
    final FirebaseUser user = auth.getCurrentUser();
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
            onPressed: () async {
              if (user == null) {
                print('Logging in');
                Navigator.of(context).pushNamed('/login');
              } else {
                print('Signing out');
                await auth.signOut();
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed('/settings');
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        child: ListView.builder(
          itemBuilder: (_, i) {
            if (i < _lSupplies.length) {
              return buildItem(_, _lSupplies[i]);
            } else {
              return _hasMore
                  ? Center(
                      child: CircularProgressIndicator(
                        value: null,
                      ),
                    )
                  : null;
            }
          },
          itemCount: _lSupplies.length + 1,
        ),
      ),
      bottomNavigationBar: BottomTabBar(
        items: items,
        selectedIndex: 1,
      ),
      floatingActionButton: user != null
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/add');
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

@JsonSerializable(nullable: false)
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
    this.imageURL,
  });

  factory Supply.fromJson(Map<String, dynamic> json) => _$SupplyFromJson(json);

  Map<String, dynamic> toJson() => _$SupplyToJson(this);
}

@JsonSerializable(nullable: false)
class Store {
  final String name;
  final String locationName;

  Store({@required this.name, @required this.locationName});

  factory Store.walmart({@required String location}) =>
      Store(name: 'Walmart', locationName: location);

  factory Store.target({@required String location}) =>
      Store(name: 'Target', locationName: location);

  String toString() => '$locationName $name';

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);

  Map<String, dynamic> toJson() => _$StoreToJson(this);
}
