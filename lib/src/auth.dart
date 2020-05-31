import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<FirebaseUser> _handleSigninWithGoogle(GoogleSignIn googleSignIn) async {
  final GoogleSignInAccount googleUser = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
  print("signed in " + user.displayName);
  return user;
}

Future<FirebaseUser> _handleSignUp(String email, String password) async {
  final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
    email: email,
    password: password,
  ))
      .user;
  print('Signed user up: ');
}

Future<FirebaseUser> _handleSigninWithEmail(
    String email, String password) async {
  AuthResult authResult = await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password);
  final FirebaseUser user = authResult.user;

  assert(user != null);
  assert(await user.getIdToken() != null);

  print("Signed in user:");
  return user;
}

Future<void> _handleSignout(GoogleSignIn googleSignIn) async {
  await googleSignIn.signOut();
  await FirebaseAuth.instance.signOut();
  print('Signed out user:');
}

Future<FirebaseUser> _getCurrentUser() {
  return FirebaseAuth.instance.currentUser();
}

abstract class BaseAuth with ChangeNotifier {
  Future<void> signInWithEmail(String email, String password);
  Future<void> signInWithGoogle();
  Future<void> signUp(String email, String password);
  Future<void> signOut();
  Future<void> fetchCurrentUser();
  FirebaseUser getCurrentUser();
}

class Auth with ChangeNotifier implements BaseAuth {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseUser user;

  Future<void> signInWithEmail(String email, String password) async {
    user = await _handleSigninWithEmail(email, password);
    notifyListeners();
  }

  Future<void> signInWithGoogle() async {
    user = await _handleSigninWithGoogle(_googleSignIn);
    notifyListeners();
  }

  Future<void> signUp(String email, String password) async {
    user = await _handleSignUp(email, password);
    notifyListeners();
  }

  Future<void> signOut() async {
    await _handleSignout(_googleSignIn);
    user = null;
    notifyListeners();
  }

  Future<void> fetchCurrentUser() async {
    user = await _getCurrentUser();
    notifyListeners();
  }

  FirebaseUser getCurrentUser() {
    return user;
  }
}
