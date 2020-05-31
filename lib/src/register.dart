import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'auth.dart';

class RegisterScreen extends StatefulWidget {
  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  bool passwordsMatch = true;

  final GlobalKey<FormState> _formKey = GlobalKey();

  void _checkMatchingPasswords(String _) {
    setState(() {
      passwordsMatch = _passwordController.text == _confirmPasswordController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color btnColor = Theme.of(context).buttonTheme.colorScheme.primary;
    final Color btnTextColor =
        Theme.of(context).buttonTheme.colorScheme.onPrimary;
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
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
                      borderSide: const BorderSide(
                          color: Colors.orange, width: 2.0),
                    ),
                    hintText: 'Enter your email ID',
                    labelText: 'Email',
                    contentPadding:
                        new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  ),
                  controller: _emailController,
                  validator: (input) => input.isEmpty ? 'You must enter an email' : null,
                  autovalidate: true,
                ),
              ),
              new Container(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  decoration: new InputDecoration(
                    border: const OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.orange, width: 2.0),
                    ),
                    hintText: 'Enter your password here',
                    labelText: 'Password',
                    contentPadding:
                        new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    errorText: passwordsMatch ? null : "Passwords do not match",
                  ),
                  obscureText: true,
                  controller: _passwordController,
                  onChanged: _checkMatchingPasswords,
                  validator: (input) => input.isEmpty ? 'Password must not be empty' : null,
                ),
              ),
              new Container(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  decoration: new InputDecoration(
                    border: const OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.orange, width: 2.0),
                    ),
                    hintText: 'Confirm Password',
                    labelText: 'Confirm Password',
                    contentPadding:
                        new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    errorText: passwordsMatch ? null : "Passwords do not match",
                  ),
                  obscureText: true,
                  controller: _confirmPasswordController,
                  onChanged: _checkMatchingPasswords,
                ),
              ),
              new Container(
                padding: EdgeInsets.all(8.0),
                child: RaisedButton(
                  onPressed: (_formKey?.currentState != null) && passwordsMatch && _formKey.currentState.validate() ? () async {
                    if (!passwordsMatch) return;
                    final BaseAuth auth = Provider.of(context);
                    await auth.signUp(_emailController.text, _passwordController.text);
                    Navigator.of(context).pop();
                  } : null,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(16.0),
                  child: new Text(
                    "Register",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomTabBar(items: items, selectedIndex: 0),
    );
  }
}
