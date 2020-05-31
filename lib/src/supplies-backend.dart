import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


  checkForValue() {
    //checks if the idem exists... DOES NOT as Expected.
    var db = FirebaseDatabase.instance.reference().child("Supplies/Items");
    db.once().then((DataSnapshot snapshot){
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, value) {
        print(values["itemName"]);
      });
    });
  }

  //adds new item in the dataset
  newItem(String itemname, String price, String address) {

    FirebaseDatabase.instance.reference().child('Supplies').child('Items')
        .push().set({
      'itemName': itemname,
      'price': price,
      'Address': address,
      'downvote_count' : "0",
      'Timestamp' : DateTime.now()
    });
    print("updated");
    checkForValue();
  }

  //Does not work as intended
  List<String> list = [];
  downvoteCounter(bool downvote, String itemname, address) {
    DatabaseReference reference = FirebaseDatabase.instance.reference().child("Supplies/Items");
    reference.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, value) {
        list.add(values['downvote_count']);
      });

    });

  }
