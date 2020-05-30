import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.deepOrangeAccent,
        accentColor: Colors.deepOrangeAccent,
        fontFamily: 'Georgia',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new Container(
        child: new Column(
          children: [
            new Container(
                height: 170.0,
                width: 120.0,
                child: FlutterLogo()
            ),
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
                  helperText: '(ex.user123@gmail.com)',
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
                  helperText: '(ex. user123)',
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
                    "Login",
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
                  "Sign in with Google",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
