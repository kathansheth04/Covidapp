import 'package:covidapp/src/auth.dart';
import 'package:flutter/material.dart';
import 'package:covidapp/src/app.dart';
import 'dart:io' show Platform;

void main() async {
  final Auth auth = Auth();
  // unimplemented on iOS
  if (!Platform.isIOS) await auth.fetchCurrentUser();
  runApp(MyApp(auth));
}
