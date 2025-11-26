import 'package:flutter/material.dart';

import '../models/meal.dart';
import 'meal_card.dart';

class MealsGrid extends StatelessWidget {
  final List<Meal> meals;

  const MealsGrid({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: 200 / 244,
      ),
      itemCount: meals.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return MealCard(meal: meals[index]);
      },
    );
  }
}
