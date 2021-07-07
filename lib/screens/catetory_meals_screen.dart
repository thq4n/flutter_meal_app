import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/widgets/meal_item.dart';

class CatetogyMealsSreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> _availableMeals;

  CatetogyMealsSreen(this._availableMeals);

  @override
  _CatetogyMealsSreenState createState() => _CatetogyMealsSreenState();
}

class _CatetogyMealsSreenState extends State<CatetogyMealsSreen> {
  String? categoryTitle;
  List<Meal>? displayedMeals;
  var _loadInitData = false;

  @override
  void didChangeDependencies() {
    if (!_loadInitData) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      categoryTitle = routeArgs["title"];
      final categoryId = routeArgs["id"];
      displayedMeals = widget._availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();

      _loadInitData = true;
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void _deleteMeal(Meal meal) {
    setState(() {
      displayedMeals!.remove(meal);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle!),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(displayedMeals![index], _deleteMeal);
        },
        itemCount: displayedMeals!.length,
      ),
    );
  }
}
