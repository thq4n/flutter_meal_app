import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> availableMeals;
  FavoritesScreen(this.availableMeals);
  @override
  Widget build(BuildContext context) {
    print(availableMeals.length);
    return availableMeals.length > 0
        ? ListView.builder(
            itemBuilder: (ctx, index) {
              return MealItem(availableMeals[index], () {});
            },
            itemCount: availableMeals.length,
          )
        : Center(
            child: Text("You have no favorites yet - please add some!"),
          );
  }
}
