import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/meal.dart';

class RandomRecipeScreen extends StatelessWidget {
  const RandomRecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recipe of the Day')),
      body: FutureBuilder<Meal?>(
        future: ApiService().fetchRandomMeal(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Failed to load recipe.'));
          }
          final meal = snapshot.data!;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(
              context,
              '/meal-details',
              arguments: meal,
            );
          });

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
