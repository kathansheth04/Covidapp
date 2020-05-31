import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'testing.dart';

/* map of short state names to long ones */
final stateNames = {
  'AZ': 'arizona',
  'CA': 'california',
  'DE': 'delaware',
  'FL': 'florida',
  'MA': 'massachusetts',
  'NV': 'nevada',
  'NJ': 'new-jersey',
  'NY': 'new-york',
  'PA': 'pennsylvania',
  'TX': 'texas',
  'UT': 'utah',
  'WA': 'washington',
};

/* stream of testing sites sorted by distance to given location */
Future<List<Site>> testingSites(Position loc, String state) async {
  final url =
      'https://covid-19-testing.github.io/locations/$state/complete.json';

  final data = json
      .decode(
          (await http.get(url, headers: {'Accept': 'application/json'})).body)
      .map((m) {
        final pa = m['physical_address'][0];
        return Site(
          clinicDescription: m['name'],
          address:
              pa['address_1'] + ' ' + pa['city'] + ' ' + pa['state_province'],
          number: m['phones'][0]['number'],
          city: pa['city'],
        );
      })
      .toList()
      .cast<Site>();
  final geolocator = Geolocator();

  final distances = await Future.wait<double>([
    for (final item in data)
      () async {
        try {
          final placemark =
              (await geolocator.placemarkFromAddress(item.address)).first;
          return await geolocator.distanceBetween(loc.latitude, loc.longitude,
              placemark.position.latitude, placemark.position.longitude);
        } on PlatformException catch (e) {
          return double.infinity;
        }
      }()
  ]);

  final distancesMap = Map.fromIterables(data, distances);

  // desc
  data.sort((b, a) => distancesMap[a].compareTo(distancesMap[b]));
  return data;
}
