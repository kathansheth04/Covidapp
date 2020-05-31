import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'app.dart';
import 'testingsite.dart';
import 'url_launcher.dart';

class TestScreen extends StatefulWidget {
  @override
  TestScreenState createState() => TestScreenState();
}

class TestScreenState extends State<TestScreen> {
  final List<Site> sites = [
    Site(
      clinicDescription: 'VA Clinic',
      number: '(800)-455-0057',
      address: '39199 Liberty St',
      city: 'Fremont',
    ),
    Site(
      clinicDescription: 'CVS Site',
      number: '(559)-451-3486',
      address: '4987 N Fresno St',
      city: 'Fresno',
    ),
  ];

  Future<List<Site>> _sites;

  Widget buildItem(BuildContext context, Site site) {
    final TextStyle titleStyle =
        Theme.of(context).textTheme.headline5.copyWith(color: Colors.white);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Card(
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    '${site.clinicDescription} in ${site.city}',
                    style: titleStyle,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Text(
                '${site.clinicDescription} is available for testing at ${site.address}, '
                'and can be contacted at ${site.number}.',
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                FlatButton.icon(
                  onPressed: () async { await openMap(site.address); },
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
    _sites = () async {
      final geolocator = Geolocator();
      final position = await geolocator.getCurrentPosition();
      final state = stateNames[(await geolocator.placemarkFromPosition(position))
          .first
          .administrativeArea];
      print('State = $state');
      return await testingSites(position, state);
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Tested!'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.of(context).pushNamed('/login');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        child: FutureBuilder(
          future: _sites,
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (_, index) => buildItem(_, snapshot.data[index]),
                itemCount: snapshot.data.length,
              );
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return Center(
                child: CircularProgressIndicator(
                  value: null,
                ),
              );
            }
          },
        ),
      ),
      bottomNavigationBar: BottomTabBar(
        items: items,
        selectedIndex: 2,
      ),
    );
  }
}

class Site {
  final String clinicDescription;
  final String number;
  final String address;
  final String city;

  Site({
    @required this.clinicDescription,
    @required this.address,
    @required this.city,
    @required this.number,
  });
}
