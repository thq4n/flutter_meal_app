import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  static String routeName = "/meal-detail";
  final Function favoriteHandler;
  final List<Meal> favoritedMeals;

  MealDetailScreen(this.favoriteHandler, this.favoritedMeals);

  Widget _buildSectionTitle(BuildContext ctx, String sectionName) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        sectionName,
        style: Theme.of(ctx).textTheme.headline6,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool _isFavorited(Meal meal) {
      if (favoritedMeals.length > 0 && favoritedMeals.contains(meal)) {
        return true;
      }
      return false;
    }

    final meal = ModalRoute.of(context)!.settings.arguments as Meal;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              favoriteHandler(meal);
            },
            icon: Icon(Icons.star),
            color: _isFavorited(meal) ? Colors.yellow : Colors.black,
          )
        ],
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Container(
                height: 300,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                  child: Image.network(
                    meal.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              _buildSectionTitle(context, "Ingredients"),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 150,
                width: MediaQuery.of(context).size.width * 0.7,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.builder(
                    itemBuilder: (ctx, index) {
                      return Card(
                        color: Theme.of(context).accentColor.withOpacity(0.5),
                        child: Text(
                          meal.ingredients[index],
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20,
                                  ),
                        ),
                      );
                    },
                    itemCount: meal.ingredients.length,
                  ),
                ),
              ),
              _buildSectionTitle(context, "Steps"),
              ...meal.steps.map(
                (step) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text("${meal.steps.indexOf(step) + 1}"),
                        ),
                        title: Text(step),
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.3,
                  vertical: 10,
                ),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(meal);
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor.withOpacity(0.5),
        mini: true,
        onPressed: () {
          Navigator.of(context).popUntil(
            (route) {
              return route.isFirst;
            },
          );
        },
        child: Icon(
          Icons.home,
          color: Colors.black.withOpacity(0.5),
        ),
      ),
    );
  }
}
