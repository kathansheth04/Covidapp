import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import'dart:convert';

String address = '';
String name = '';
String phoneNum = '';

TextEditingController addressController = new TextEditingController();
TextEditingController nameController = new TextEditingController();
TextEditingController phoneNumController = new TextEditingController();

String url = 'https://covid-19-testing.github.io/locations/california/complete.json';

getData(int x) async {
  String profile = url;
  var res = await http.get(profile,headers: {"Accept":"application/json"});
  List data = json.decode(res.body);
  final dataMap = data.asMap();
  var orgData = dataMap[x];
  var addressInfo = orgData['physical_address'];
  var location = addressInfo[0]["address_1"];
  var city = addressInfo[0]["city"];
  address = location + ", " + city;

  name = orgData["name"];
  print(name);
  var contactInformation = orgData["phones"];
  phoneNum  = contactInformation[0]["number"];
  print(phoneNum);
}