import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';



class MyApp {

  Future<FirebaseAuth> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  changeAddress(String Address) {
    FirebaseDatabase.instance.reference().child(
        'Users/' + FirebaseAuth.instance.currentUser().toString()).set({
      'User Address': Address
    });
  }
}
