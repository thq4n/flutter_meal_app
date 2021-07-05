import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';

class MealItem extends StatelessWidget {
  final Meal meal;

  MealItem(this.meal);
  void _selectMeal() {}

  String get complexityText {
    var _complexity = meal.complexity;
    switch (_complexity) {
      case Complexity.Simple:
        return "Simple";
      case Complexity.Hard:
        return "Hard";
      case Complexity.Challenging:
        return "Challenging";
      default:
        return "Unknown";
    }
  }

  String get affordabilityText {
    var _affordability = meal.affordability;
    switch (_affordability) {
      case Affordability.Pricey:
        return "Pricey";
      case Affordability.Luxurious:
        return "Luxurious";
      case Affordability.Affordable:
        return "Affordable";
      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectMeal(),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    meal.imageUrl,
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 220,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: Text(
                      meal.title,
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.schedule),
                      SizedBox(
                        width: 6,
                      ),
                      Text("${meal.duration} min"),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.star_border),
                      SizedBox(
                        width: 6,
                      ),
                      Text(complexityText),
                    ],
                  ),Row(
                    children: <Widget>[
                      Icon(Icons.attach_money_rounded),
                      SizedBox(
                        width: 6,
                      ),
                      Text(affordabilityText),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
