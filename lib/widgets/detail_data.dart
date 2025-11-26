import 'package:flutter/material.dart';

import '../models/meal.dart';

class DetailData extends StatelessWidget {
  final Meal meal;

  const DetailData({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Information',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _infoRow('Category', meal.category),
          const SizedBox(height: 16),
          const Text(
            'Ingredients',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...meal.ingredients.map(
                (ing) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text('• $ing'),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Instructions',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            meal.instructions,
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 16),
          if (meal.youtubeUrl.isNotEmpty) ...[
            const Text(
              'YouTube link',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              meal.youtubeUrl,
              style: const TextStyle(color: Colors.blue),
            ),
          ],
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 16)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style:
            const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
