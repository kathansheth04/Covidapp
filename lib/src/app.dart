import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';
import 'login.dart';
import 'register.dart';
import 'auth.dart';
import 'add.dart';

class MyApp extends StatelessWidget {
  final BaseAuth auth;

  MyApp(this.auth, {Key key})
      : assert(auth != null),
        super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BaseAuth>(
      create: (_) => auth,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.orange,
          accentColor: Colors.orangeAccent,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          primarySwatch: Colors.orange,
          primaryColor: Colors.orange,
          accentColor: Colors.orangeAccent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          brightness: Brightness.dark,
        ),
        routes: {
          '/login': (_) => LoginScreen(),
          '/register': (_) => RegisterScreen(),
          '/add': (_) => AddScreen(),
        },
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class BottomTabBar extends StatelessWidget {
  final List<TabBarItem> items;
  final int selectedIndex;

  BottomTabBar({Key key, this.items, this.selectedIndex})
      : assert(selectedIndex < items.length),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      items: [
        for (TabBarItem item in items)
          BottomNavigationBarItem(
            icon: item.icon,
            title: Text(item.title),
          ),
      ],
      onTap: (index) {
        items[index].route(context);
      },
    );
  }
}

class TabBarItem {
  final Icon icon;
  final String title;
  final void Function(BuildContext) route;

  TabBarItem({@required this.icon, @required this.title, @required this.route});
}

final List<TabBarItem> items = [
  TabBarItem(icon: Icon(Icons.history), title: 'Settings', route: (_) {}),
  TabBarItem(
      icon: Icon(Icons.local_grocery_store),
      title: 'Supplies',
      route: (context) {
        Navigator.of(context).pushReplacementNamed('/');
      }),
  TabBarItem(
      icon: Icon(Icons.my_location), title: 'Testing Sites', route: (_) {}),
];
