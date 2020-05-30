import 'package:flutter/material.dart';
import 'app.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color btnColor = Theme.of(context).buttonTheme.colorScheme.background;
    final Color btnTextColor = Theme.of(context).buttonTheme.colorScheme.onBackground;

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        child: new Column(
          children: [
            new Container(height: 150.0, width: 100.0, child: FlutterLogo()),
            new Container(
              width: 370,
              padding: EdgeInsets.all(10.0),
              child: TextField(
                decoration: new InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepOrangeAccent, width: 2.0),
                  ),
                  hintText: 'Enter your email ID',
                  labelText: 'Email',
                  contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 100.0, 10.0),
                ),
              ),
            ),
            new Container (
              width: 370,
              padding: EdgeInsets.all(10.0),
              child: TextField(
                decoration: new InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepOrangeAccent, width: 2.0),
                  ),
                  hintText: 'Enter your password here',
                  labelText: 'Password',
                  contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 100.0, 10.0),
                ),
              ),
            ),
            new Container(
              width: 370,
              padding: EdgeInsets.all(10.0),
              child: TextField(
                decoration: new InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepOrangeAccent, width: 2.0),
                  ),
                  hintText: 'Confirm Password',
                  labelText: 'Confirm Password',
                  contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 100.0, 10.0),
                ),
              ),
            ),
            new Container(
              height: 68,
              width: 370,
              padding: EdgeInsets.all(10.0),
              child: RaisedButton(
                onPressed: () => {},
                textColor: Colors.black,
                color: Colors.deepOrangeAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(8.0),
                child: new Text(
                  "Register",
                ),
              ),
            ),

          ],
        ),
      ),
      bottomNavigationBar: BottomTabBar(items: items, selectedIndex: 0),
    );
  }
}
