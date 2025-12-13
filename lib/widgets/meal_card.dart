import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/meal.dart';
import '../services/favorites_service.dart';

class MealCard extends StatelessWidget {
  final Meal meal;

  const MealCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/meal-details',
          arguments: meal,
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.orange.shade300, width: 3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        meal.thumbnail,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  const Divider(),
                  Text(
                    meal.name,
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              Positioned(
                top: 0,
                right: 0,
                child: Consumer<FavoritesService>(
                  builder: (context, favService, _) {
                    final isFav = favService.isFavorite(meal);
                    return IconButton(
                      icon: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        favService.toggleFavorite(meal);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
