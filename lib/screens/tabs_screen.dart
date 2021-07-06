import 'package:flutter/material.dart';
import 'package:meal_app/screens/categories_screen.dart';

import 'favorites_sreen.dart';

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final List<Map<String, Object>> _pages = [
    {
      "page": CategoriesScreen(),
      "title": "Categories",
      "icon": Icons.category,
    },
    {
      "page": FavoritesScreen(),
      "title": "Favorites",
      "icon": Icons.favorite,
    },
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int value) {
    setState(() {
      _selectedPageIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pages[_selectedPageIndex]["title"].toString(),
        ),
      ),
      drawer: Drawer(
        child: Text("haha"),
      ),
      body: _pages[_selectedPageIndex]["page"] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          ..._pages.map(
            (page) {
              return BottomNavigationBarItem(
                icon: Icon(
                  page["icon"] as IconData,
                ),
                label: page["title"].toString(),
              );
            },
          ),
        ],
      ),
    );
  }
}
