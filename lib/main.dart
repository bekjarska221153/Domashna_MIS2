import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/meals_by_category.dart';
import 'screens/meals_details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'Meal Categories'),
        '/meals': (context) => const MealsByCategoryScreen(),
        '/mealDetails': (context) => const MealDetailsScreen(),
      },
    );
  }
}
