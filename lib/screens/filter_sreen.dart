import 'package:flutter/material.dart';
import 'package:meal_app/models/filters.dart';
import 'package:meal_app/screens/tabs_screen.dart';
import 'package:meal_app/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static String routeName = "/filters";
  final Function saveFilters;
  final Map<FilterOption, bool> currentFilters;

  FilterScreen(this.saveFilters, this.currentFilters);
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<Map<String, Object>> _switchButtons = [];

  bool get _getGluten {
    return _switchButtons
        .where((element) {
          return element["id"] == FilterOption.Gluten;
        })
        .toList()
        .first["value"] as bool;
  }

  bool get _getVegan {
    return _switchButtons
        .where((element) {
          return element["id"] == FilterOption.Vegan;
        })
        .toList()
        .first["value"] as bool;
  }

  bool get _getVegetarian {
    return _switchButtons
        .where((element) {
          return element["id"] == FilterOption.Vegetarian;
        })
        .toList()
        .first["value"] as bool;
  }

  bool get _getLactose {
    return _switchButtons
        .where((element) {
          return element["id"] == FilterOption.Lactose;
        })
        .toList()
        .first["value"] as bool;
  }

  Widget _buildSwitchListTile(Map<String, Object> btn) {
    return SwitchListTile(
      activeColor: Colors.amberAccent,
      title: Text(
        btn["title"].toString(),
      ),
      subtitle: Text(
        btn["subtitle"].toString(),
      ),
      value: btn["value"] as bool,
      onChanged: (value) {
        setState(
          () {
            btn["value"] = value;
          },
        );
      },
    );
  }

  @override
  void initState() {
    _switchButtons = [
      {
        "id": FilterOption.Gluten,
        "title": "Gluten-free",
        "value": widget.currentFilters[FilterOption.Gluten] as bool,
        "subtitle": "Only include gluten-free meals",
      },
      {
        "id": FilterOption.Lactose,
        "title": "Lactose-free",
        "value": widget.currentFilters[FilterOption.Lactose] as bool,
        "subtitle": "Only include lactose-free meals",
      },
      {
        "id": FilterOption.Vegetarian,
        "title": "Vegetarian",
        "value": widget.currentFilters[FilterOption.Vegetarian] as bool,
        "subtitle": "Only include vegetarian meals",
      },
      {
        "id": FilterOption.Vegan,
        "title": "Vegan",
        "value": widget.currentFilters[FilterOption.Vegan] as bool,
        "subtitle": "Only include vegan meals",
      },
    ];
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(TabScreen.routeName);
            },
          ),
        ],
        title: Text("Filter"),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust your meal selection",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ..._switchButtons.map(
                  (btn) {
                    return _buildSwitchListTile(btn);
                  },
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: Icon(Icons.save),
        onPressed: () {
          widget.saveFilters(
            _getGluten,
            _getLactose,
            _getVegan,
            _getVegetarian,
          );
        },
      ),
    );
  }
}
