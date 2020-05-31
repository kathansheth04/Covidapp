import 'package:flutter/material.dart';
import 'app.dart';


class HomeScreen extends StatelessWidget {
  final List<Site> Sites = [
    Site(
      clinicDescription: 'VA Clinic',
      number: '(800)-455-0057',
      address: '39199 Liberty St',
      city: City.Fremont(location: 'Union Landing'),
    ),
    Site(
      clinicDescription: 'CVS Site',
      number: '(559)-451-3486',
      address: '4987 N Fresno St',
      city: City.Fresno(location: 'Union Landing'),
    ),

  ];

  Widget buildItem(BuildContext context, int index) {
    final Site site = Sites[index];
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
                    '${site.clinicDescription} in ${site.city.name}',
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
        child: ListView.builder(
          itemBuilder: buildItem,
          itemCount: Sites.length,
        ),
      ),
      bottomNavigationBar: BottomTabBar(
        items: items,
        selectedIndex: 1,
      ),
    );
  }
}

class Site {
  final String clinicDescription;
  final String number;
  final String address;
  final City city;

  Site({
    @required this.clinicDescription,
    @required this.address,
    @required this.city,
    @required this.number,
  });
}

class City {
  final String name;
  final String locationName;

  City._({@required this.name, @required this.locationName});

  factory City.Fremont({@required String location}) =>
      City._(name: 'Fremont', locationName: location);
  factory City.Fresno({@required String location}) =>
      City._(name: 'Fresno', locationName: location);

  String toString() => '$locationName $name';
}
