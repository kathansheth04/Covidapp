import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

/*void auth() {
  runApp(MyApp());
}*/

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();
Future<FirebaseUser> _handleSigninWithGoogle() async {
  final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
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

Future<FirebaseUser> _handleSigninWithEmail(String email, String password) async {
  AuthResult authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  final FirebaseUser user = authResult.user;

  assert(user != null);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
  print("Signed in user:");
}
/*
class MyApp extends StatelessWidget {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
            title: Text("Hello")
        ),
        body: new Container(
          child: new Column(
            children: [
              new Container(
                child: new TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email'
                  ),
                ),
              ),
              new Container(
                child: TextField(
                  controller: passController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password'
                  ),
                ),
              ),
              new Container(
                  child: FlatButton(
                    onPressed: () {
                      _handleSigninWithGoogle();
                    },
                    child: Text(
                        "login"
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
 */
