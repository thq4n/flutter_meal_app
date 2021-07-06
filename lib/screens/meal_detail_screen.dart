import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  static String routeName = "/meal-detail";

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
    final meal = ModalRoute.of(context)!.settings.arguments as Meal;
    return Scaffold(
      appBar: AppBar(
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
              ...meal.steps.map((step) {
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
              })
            ],
          ),
        ),
      ),
    );
  }
}
