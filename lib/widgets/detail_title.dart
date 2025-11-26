import 'package:flutter/material.dart';

class DetailTitle extends StatelessWidget {
  final String name;
  final String category;

  const DetailTitle({super.key, required this.name, required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          name,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          category,
          style: const TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ],
    );
  }
}
