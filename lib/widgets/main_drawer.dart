import 'package:flutter/material.dart';
import 'package:meal_app/screens/categories_screen.dart';
import 'package:meal_app/screens/filter_sreen.dart';
import 'package:meal_app/screens/tabs_screen.dart';

class MainDrawer extends StatelessWidget {
  List<Widget> _buildListTile(
      String title, IconData icon, Function tapHandler) {
    return [
      ListTile(
        leading: Icon(
          icon,
          size: 26,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: "RotoboCondensed",
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () => tapHandler(),
      ),
      Divider(
        thickness: 3,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 100 + MediaQuery.of(context).padding.top,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
              ),
              child: Text(
                "Options",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ..._buildListTile(
            "Meals",
            Icons.restaurant,
            () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(TabScreen.routeName);
            },
          ),
          ..._buildListTile(
            "Filters",
            Icons.settings,
            () {
              Navigator.of(context).pop();
              Navigator.of(context)
                  .pushReplacementNamed(FilterScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
