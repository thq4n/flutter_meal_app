import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/models/filters.dart';
import 'package:meal_app/screens/catetory_meals_screen.dart';
import 'package:meal_app/screens/filter_sreen.dart';
import 'package:meal_app/screens/meal_detail_screen.dart';

import 'models/meal.dart';
import 'screens/tabs_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<FilterOption, bool> _filters = {
    FilterOption.Gluten: false,
    FilterOption.Lactose: false,
    FilterOption.Vegan: false,
    FilterOption.Vegetarian: false,
  };

  List<Meal> _filteredMeals = DUMMY_MEALS;
  List<Meal> _favoritedMeals = [];

  void _setFilter(
    bool gluten,
    bool lactose,
    bool vegan,
    bool vegetarian,
  ) {
    setState(() {
      _filters[FilterOption.Gluten] = gluten;
      _filters[FilterOption.Lactose] = lactose;
      _filters[FilterOption.Vegan] = vegan;
      _filters[FilterOption.Vegetarian] = vegetarian;

      _filteredMeals = DUMMY_MEALS.where((meal) {
        if (_filters[FilterOption.Gluten] as bool && !meal.isGlutenFree) {
          return false;
        }
        if (_filters[FilterOption.Lactose] as bool && !meal.isLactoseFree) {
          return false;
        }
        if (_filters[FilterOption.Vegan] as bool && !meal.isVegan) {
          return false;
        }
        if (_filters[FilterOption.Vegetarian] as bool && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(Meal meal) {
    setState(() {
      if (_favoritedMeals.contains(meal)) {
        _favoritedMeals.remove(meal);
      } else {
        _favoritedMeals.add(meal);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        accentColor: Colors.grey,
        primarySwatch: Colors.brown,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: "Raleway",
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                  fontSize: 24,
                  fontFamily: "RobotoCondensed",
                  fontWeight: FontWeight.bold),
            ),
      ),
      initialRoute: TabScreen.routeName,
      routes: {
        TabScreen.routeName: (ctx) => TabScreen(_favoritedMeals),
        CatetogyMealsSreen.routeName: (ctx) =>
            CatetogyMealsSreen(_filteredMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavorite,_favoritedMeals),
        FilterScreen.routeName: (ctx) => FilterScreen(_setFilter, _filters),
      },
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Container(),
//     );
//   }
// }
