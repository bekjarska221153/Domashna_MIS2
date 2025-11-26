import 'package:flutter/material.dart';

import '../models/meal_category.dart';
import 'category_card.dart';

class CategoryGrid extends StatelessWidget {
  final List<MealCategory> categories;

  const CategoryGrid({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: 200 / 240,
      ),
      itemCount: categories.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return CategoryCard(category: categories[index]);
      },
    );
  }
}
