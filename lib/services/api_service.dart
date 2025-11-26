import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/meal_category.dart';
import '../models/meal.dart';

class ApiService {
  static const String _baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  Future<List<MealCategory>> fetchCategories() async {
    final response = await http.get(Uri.parse('$_baseUrl/categories.php'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List categoriesJson = data['categories'] ?? [];
      return categoriesJson
          .map((json) => MealCategory.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<Meal>> fetchMealsByCategory(String category) async {
    final response =
    await http.get(Uri.parse('$_baseUrl/filter.php?c=$category'));

    if (response.statusCode != 200) {
      throw Exception('Failed to load meals for category $category');
    }

    final data = json.decode(response.body);
    final List mealsJson = data['meals'] ?? [];

    List<Meal> meals = [];

    for (var item in mealsJson) {
      final id = item['idMeal'];
      if (id == null) continue;

      final detailResponse =
      await http.get(Uri.parse('$_baseUrl/lookup.php?i=$id'));

      if (detailResponse.statusCode == 200) {
        final detailData = json.decode(detailResponse.body);
        final List detailMeals = detailData['meals'] ?? [];
        if (detailMeals.isNotEmpty) {
          meals.add(Meal.fromDetailJson(detailMeals.first));
        }
      }
    }

    return meals;
  }

  Future<List<Meal>> searchMealsByName(String query) async {
    if (query.trim().isEmpty) return [];

    final response =
    await http.get(Uri.parse('$_baseUrl/search.php?s=$query'));

    if (response.statusCode != 200) return [];

    final data = json.decode(response.body);
    final List mealsJson = data['meals'] ?? [];
    return mealsJson.map((json) => Meal.fromDetailJson(json)).toList();
  }

  Future<List<Meal>> searchMealsInCategory(
      String category, String query) async {
    final all = await searchMealsByName(query);
    return all.where((m) => m.category == category).toList();
  }

  Future<Meal?> fetchRandomMeal() async {
    final response = await http.get(Uri.parse('$_baseUrl/random.php'));

    if (response.statusCode != 200) return null;

    final data = json.decode(response.body);
    final List mealsJson = data['meals'] ?? [];
    if (mealsJson.isEmpty) return null;

    return Meal.fromDetailJson(mealsJson.first);
  }
}
