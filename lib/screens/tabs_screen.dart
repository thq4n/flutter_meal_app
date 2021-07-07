import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/categories_screen.dart';
import 'package:meal_app/widgets/main_drawer.dart';

import 'favorites_sreen.dart';

class TabScreen extends StatefulWidget {
  static String routeName = "/";
  List<Meal> favoritedMeals;

  TabScreen(this.favoritedMeals);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Map<String, Object>> _pages = [];

  int _selectedPageIndex = 0;

  void _selectPage(int value) {
    setState(() {
      _selectedPageIndex = value;
    });
  }

  @override
  void didChangeDependencies() {
    _pages = [
      {
        "page": CategoriesScreen(),
        "title": "Categories",
        "icon": Icons.category,
      },
      {
        "page": FavoritesScreen(widget.favoritedMeals),
        "title": widget.favoritedMeals.length.toString(), //"Favorites",
        "icon": Icons.favorite,
      },
    ];
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print("tabs ${widget.favoritedMeals.length}");
    print(_pages[1]["title"].toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pages[_selectedPageIndex]["title"].toString(),
        ),
      ),
      drawer: MainDrawer(),
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
