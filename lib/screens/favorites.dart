import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/favorites_service.dart';
import '../widgets/meals_grid.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesService>().favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Meals'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: favorites.isEmpty
          ? const Center(
        child: Text(
          'Not added to favorites yet!',
          style: TextStyle(fontSize: 18),
        ),
      )
          : MealsGrid(meals: favorites),
    );
  }
}
