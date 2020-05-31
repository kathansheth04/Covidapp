
import 'package:flutter/material.dart';
import 'app.dart';

class AddScreen extends StatelessWidget {

  Widget build(BuildContext context) {
    final Color btnColor = Theme.of(context).buttonTheme.colorScheme.background;
    final Color btnTextColor = Theme.of(context).buttonTheme.colorScheme.onBackground;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Items'),
      ),
      body: SingleChildScrollView(
        child: new Column(
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
              width: 340,
              padding: EdgeInsets.only(top: 30),
              child: TextField(
                decoration: new InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.orange, width: 2.0),
                  ),
                  hintText: 'Name of Item',
                  labelText: 'Name of Item',
                  contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 100.0, 10.0),
                ),
              ),
            ),
            new Container (
              width: 340,
              padding: EdgeInsets.only(top: 20),
              child: TextField(
                decoration: new InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.orange, width: 2.0),
                  ),
                  hintText: 'Enter the Store Name Here',
                  labelText: 'Store Name at which found',
                  contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 100.0, 10.0),
                ),
              ),
            ),
            new Container(
              width: 340,
              padding: EdgeInsets.only(top: 20),
              child: TextField(
                decoration: new InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.orange, width: 2.0),
                  ),
                  hintText: 'Enter address here',
                  labelText: 'Address of location found',
                  contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 100.0, 10.0),
                ),
              ),
            ),
            new Container(
              height: 68,
              width: 340,
              padding: EdgeInsets.only(top: 20),
              child: RaisedButton(
                onPressed: () => {},
                textColor: Colors.black,
                color: Colors.orange,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(8.0),
                child: new Text(
                  "Update",
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ),

          ],
        ),
      ),
      bottomNavigationBar: BottomTabBar(items: items, selectedIndex: 0),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        label: Text('Add anothet Item'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
