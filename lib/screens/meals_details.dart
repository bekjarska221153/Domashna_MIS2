import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/detail_image.dart';
import '../widgets/detail_title.dart';
import '../widgets/detail_data.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context)!.settings.arguments as Meal;

    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 16.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 20),
            DetailImage(image: meal.thumbnail),
            const SizedBox(height: 20),
            DetailTitle(name: meal.name, category: meal.category),
            const SizedBox(height: 30),
            DetailData(meal: meal),
          ],
        ),
      ),
    );
  }
}
