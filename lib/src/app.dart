import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';
import 'login.dart';
import 'register.dart';
import 'add.dart';
import 'testing.dart';

//import 'settings.dart';
import 'auth.dart';

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
          primarySwatch: Colors.orange,
          accentColor: Colors.orangeAccent,
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
          '/test': (_) => TestScreen(),
          //'/settings': (_) => SettingsScreen(),
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
        if (selectedIndex != index) items[index].route(context);
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
      icon: Icon(Icons.my_location),
      title: 'Testing Sites',
      route: (context) {
        Navigator.of(context).pushReplacementNamed('/test');
      }),
];
