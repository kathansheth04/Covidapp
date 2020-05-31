import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'login.dart';
import 'register.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.orangeAccent,
          primarySwatch: Colors.orange
      ),      
      routes: {
        '/login': (_) => LoginScreen(),
        '/register': (_) => RegisterScreen(),
      },
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
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
