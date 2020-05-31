
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'app.dart';

class AddScreen extends StatelessWidget {

  Widget build(BuildContext context) {
    final Color btnColor = Theme.of(context).buttonTheme.colorScheme.primary;
    final Color btnTextColor = Theme.of(context).buttonTheme.colorScheme.onPrimary;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Items'),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              new Container(
                padding: EdgeInsets.only(top: 24),
                child: Text(
                  'Thank you for choosing to add items, please answer all of the questions as accurately as possible!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              new Container(
                padding: EdgeInsets.only(top: 30),
                child: TextFormField(
                  decoration: new InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.orange, width: 2.0),
                    ),
                    hintText: 'Name of Item',
                    labelText: 'Name of Item',
                    contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  ),
                  validator: (input) => input.isEmpty ? 'Item name must not be empty' : null,
                  autovalidate: true,
                ),
              ),
              new Container (
                padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  decoration: new InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.orange, width: 2.0),
                    ),
                    hintText: 'Enter the Store Name Here',
                    labelText: 'Store Name at which found',
                    contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  ),
                  validator: (input) => input.isEmpty ? 'Store name must not be empty' : null,
                  autovalidate: true,
                ),
              ),
              new Container (
                padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  decoration: new InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.orange, width: 2.0),
                    ),
                    hintText: 'Enter the Store Location Name Here',
                    labelText: 'Store Location at which found',
                    contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  ),
                  validator: (input) => input.isEmpty ? 'Store location name must not be empty' : null,
                  autovalidate: true,
                ),
              ),
              new Container(
                padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  decoration: new InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.orange, width: 2.0),
                    ),
                    hintText: 'Enter address here',
                    labelText: 'Address of location found',
                    contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  ),
                  validator: (input) => input.isEmpty ? 'Address must not be empty' : null,
                ),
              ),
              new Container(
                padding: EdgeInsets.only(top: 20),
                child: RaisedButton(
                  onPressed: () => {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(16.0),
                  child: new Text(
                    "Update",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        label: Text('Add another Item'),
        icon: Icon(Icons.add),
      ),
    );
  }
}
