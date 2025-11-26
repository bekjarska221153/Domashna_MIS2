import 'package:flutter/material.dart';

import '../models/meal_category.dart';

class CategoryCard extends StatelessWidget {
  final MealCategory category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/meals',
          arguments: category.name,
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.orange.shade300, width: 3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: Image.network(category.thumbnail, fit: BoxFit.cover),
              ),
              const Divider(),
              Text(
                category.name,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                category.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
