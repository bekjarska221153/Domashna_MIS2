import 'package:domasna2_mis/screens/random_recipe.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'screens/home.dart';
import 'screens/meals_by_category.dart';
import 'screens/meals_details.dart';
import 'screens/favorites.dart';
import 'services/favorites_service.dart';
import 'services/notification_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  tz.initializeTimeZones();

  await NotificationService.init();
  await NotificationService.scheduleDailyRecipeNotification();
  //await NotificationService.showRecipeNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FavoritesService(),
      child: MaterialApp(
        title: 'Recipe App',
        navigatorKey: navigatorKey,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const MyHomePage(title: 'Meal Categories'),
          '/meals': (context) => const MealsByCategoryScreen(),
          '/meal-details': (context) => const MealDetailsScreen(),
          '/favorites': (context) => const FavoritesScreen(),
          '/random-recipe': (context) => const RandomRecipeScreen()
        },
      ),
    );
  }
}
