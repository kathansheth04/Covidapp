import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'home_screen.dart';

class Supply2 {
  final String id;
  final Supply supply;

  Supply2({@required this.id, @required this.supply});
}

/* returns item ID */
Future<String> addSupply(Supply supply) async {
  final db = FirebaseDatabase.instance.reference().child('supplies');
  final child = db.push();
  await child.set(supply.toJson());
  return child.key;
}

Stream<Supply2> listSupplies() {
  final db = FirebaseDatabase.instance.reference().child('supplies');
  return db
      .orderByChild('spotted')
      .onChildAdded
      .map((event) {
    final v = Map<String, dynamic>.from(event.snapshot.value);
    return Supply2(
      id: event.snapshot.key, supply: Supply.fromJson(v),);
  });
}

Future<void> downvoteItem(String id) async {
  final db = FirebaseDatabase.instance.reference().child('supplies');
  final child = db.child(id);
  final newDownvotes = ((await child.once()).value['downvotes'] as int) + 1;
  if (newDownvotes >= 4) {
    await child.remove();
  } else {
    await child.update({
      'downvotes': newDownvotes,
    });
  }
}