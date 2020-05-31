import 'package:covidapp/src/supplies_backend.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'auth.dart';
import 'home_screen.dart';

class AddScreen extends StatefulWidget {
  @override
  AddScreenState createState() => AddScreenState();
}

class AddScreenState extends State<AddScreen> {
  TextEditingController _itemController = TextEditingController();
  TextEditingController _storeController = TextEditingController();
  TextEditingController _storeLocationController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  Widget build(BuildContext context) {
    final Color btnColor = Theme.of(context).buttonTheme.colorScheme.primary;
    final Color btnTextColor =
        Theme.of(context).buttonTheme.colorScheme.onPrimary;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Items'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                      borderSide:
                          const BorderSide(color: Colors.orange, width: 2.0),
                    ),
                    hintText: 'Name of Item',
                    labelText: 'Name of Item',
                    contentPadding:
                        new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  ),
                  controller: _itemController,
                  validator: (input) =>
                      input.isEmpty ? 'Item name must not be empty' : null,
                ),
              ),
              new Container(
                padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  decoration: new InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.orange, width: 2.0),
                    ),
                    hintText: 'Enter the Store Name Here',
                    labelText: 'Store Name at which found',
                    contentPadding:
                        new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  ),
                  controller: _storeController,
                  validator: (input) =>
                      input.isEmpty ? 'Store name must not be empty' : null,
                ),
              ),
              new Container(
                padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  decoration: new InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.orange, width: 2.0),
                    ),
                    hintText: 'Enter the Store Location Name Here',
                    labelText: 'Store Location at which found',
                    contentPadding:
                        new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  ),
                  controller: _storeLocationController,
                  validator: (input) => input.isEmpty
                      ? 'Store location name must not be empty'
                      : null,
                ),
              ),
              new Container(
                padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  decoration: new InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.orange, width: 2.0),
                    ),
                    hintText: 'Enter address here',
                    labelText: 'Address of location found',
                    contentPadding:
                        new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  ),
                  controller: _addressController,
                  validator: (input) =>
                      input.isEmpty ? 'Address must not be empty' : null,
                ),
              ),
              new Container(
                padding: EdgeInsets.only(top: 20),
                child: RaisedButton(
                  onPressed: () async {
                    if (!_formKey.currentState.validate()) return;
                    // create supply
                    BaseAuth auth = Provider.of(context);
                    final supply = Supply(
                      itemDescription: _itemController.text,
                      address: _addressController.text,
                      store: Store(
                        name: _storeController.text,
                        locationName: _storeLocationController.text,
                      ),
                      username: auth.getCurrentUser().displayName,
                      spotted: DateTime.now(),
                    );
                    await addSupply(supply);
                    Navigator.of(context).pop();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(16.0),
                  child: new Text(
                    "Add",
                    style: TextStyle(fontSize: 17),
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
