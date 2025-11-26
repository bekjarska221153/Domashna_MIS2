import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../services/api_service.dart';
import '../widgets/meals_grid.dart';

class MealsByCategoryScreen extends StatefulWidget {
  const MealsByCategoryScreen({super.key});

  @override
  State<MealsByCategoryScreen> createState() => _MealsByCategoryScreenState();
}

class _MealsByCategoryScreenState extends State<MealsByCategoryScreen> {
  final ApiService _apiService = ApiService();

  String? _category;
  bool _isLoading = true;
  bool _isSearching = false;
  late List<Meal> _meals;
  List<Meal> _filteredMeals = [];
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _category = ModalRoute.of(context)!.settings.arguments as String?;
      if (_category != null) {
        _loadMeals(_category!);
      }
      _initialized = true;
    }
  }

  Future<void> _loadMeals(String category) async {
    try {
      final meals = await _apiService.fetchMealsByCategory(category);
      setState(() {
        _meals = meals;
        _filteredMeals = meals;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterMeals(String query) {
    setState(() {
      _searchQuery = query;
      _filteredMeals = _meals
          .where((m) =>
          m.name.toLowerCase().contains(query.toLowerCase().trim()))
          .toList();
    });
  }

  Future<void> _searchMealsInApi(String query) async {
    if (_category == null || query.trim().isEmpty) return;

    setState(() {
      _isSearching = true;
    });

    final results =
    await _apiService.searchMealsInCategory(_category!, query);

    setState(() {
      _isSearching = false;
      _filteredMeals = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    final title = _category ?? 'Meals';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search meals in $title...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: _filterMeals,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _isSearching
                    ? null
                    : () async {
                  await _searchMealsInApi(_searchQuery);
                },
                child: _isSearching
                    ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
                    : const Text('Search in API'),
              ),
            ),
          ),
          Expanded(
            child: MealsGrid(meals: _filteredMeals),
          ),
        ],
      ),
    );
  }
}
