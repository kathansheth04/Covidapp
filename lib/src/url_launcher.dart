import 'dart:io' show Platform;

import 'package:url_launcher/url_launcher.dart';

Future<void> openMap(String address) async {
  address = Uri.encodeQueryComponent(address);
  String googleURL1 =
      'https://www.google.com/maps/search/?api=1&query=$address';
  String googleURL2 =
      'comgooglemaps://?q=$address';
  String appleURL = 'https://maps.apple.com/?q=$address';
  String geoURL = 'geo:0,0?q=$address';
  if (await canLaunch(geoURL)) {
    await launch(geoURL);
  } else if (await canLaunch(googleURL2)) {
    await launch(googleURL2);
  } else if (await canLaunch(googleURL1) && !Platform.isIOS) {
    await launch(googleURL1);
  } else if (await canLaunch(appleURL)) {
    await launch(appleURL);
  }
}
