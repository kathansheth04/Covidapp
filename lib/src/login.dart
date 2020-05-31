import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth.dart';
import 'app.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final Color btnColor = Theme
        .of(context)
        .buttonTheme
        .colorScheme
        .background;
    final Color btnTextColor =
        Theme
            .of(context)
            .buttonTheme
            .colorScheme
            .onBackground;
    final BaseAuth auth = Provider.of(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              new Container(height: 150.0, width: 100.0, child: FlutterLogo()),
              new Container(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  decoration: new InputDecoration(
                    border: const OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Colors.orange, width: 2.0),
                    ),
                    hintText: 'Enter your email ID',
                    labelText: 'Email',
                    contentPadding:
                    new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  ),
                  controller: _emailController,
                  validator: (input) =>
                  input.isEmpty
                      ? 'You must enter an email'
                      : null,
                  autovalidate: true,
                ),
              ),
              new Container(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  decoration: new InputDecoration(
                    border: const OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Colors.orange, width: 2.0),
                    ),
                    hintText: 'Enter your password here',
                    labelText: 'Password',
                    contentPadding:
                    new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0,),
                  ),
                  controller: _passwordController,
                  obscureText: true,
                  validator: (input) =>
                  input.isEmpty
                      ? 'You must enter a password'
                      : null,
                  autovalidate: true,
                ),
              ),
              new Container(
                padding: EdgeInsets.all(10.0),
                child: RaisedButton(
                  onPressed: (_formKey?.currentState != null) &&
                      _formKey.currentState.validate() ? () async {
                    try {
                      await auth.signInWithEmail(
                          _emailController.text, _passwordController
                          .text);
                    } on AuthException catch (e) {
                      String error;
                      switch (e.code) {
                        case 'ERROR_INVALID_EMAIL':
                        case 'ERROR_WRONG_PASSWORD':
                          error = 'Invalid email or password';
                          break;
                        case 'ERROR_USER_NOT_FOUND':
                        case 'ERROR_USER_DISABLED':
                        case 'ERROR_TOO_MANY_REQUESTS':
                        case 'ERROR_OPERATION_NOT_ALLOWED':
                          error = 'Invalid request';
                          break;
                      }
                      _scaffoldKey.currentState.showSnackBar(
                        SnackBar(content: Text(error)),
                      );
                    }
                    Navigator.of(context).pop();
                  } : null,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(16.0),
                  child: new Text(
                    "Login",
                  ),
                ),
              ),
              new Container(
                padding: EdgeInsets.all(10.0),
                child: RaisedButton(
                  onPressed: () async {
                    await auth.signInWithGoogle();
                    Navigator.of(context).pop();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(16.0),
                  child: new Text(
                    "Sign in with Google",
                  ),
                ),
              ),
              new Container(
                padding: EdgeInsets.all(10.0),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/register');
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(16.0),
                  child: new Text(
                    "Don't have an account yet? Register!",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
