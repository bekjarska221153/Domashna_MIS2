import 'package:flutter/material.dart';
import '../services/notification_service.dart';
import '../models/meal_category.dart';
import '../services/api_service.dart';
import '../widgets/category_grid.dart';
import '../models/meal.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ApiService _apiService = ApiService();

  late List<MealCategory> _categories;
  List<MealCategory> _filteredCategories = [];
  bool _isLoading = true;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  bool _isRandomLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      final cats = await _apiService.fetchCategories();
      setState(() {
        _categories = cats;
        _filteredCategories = cats;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterCategories(String query) {
    setState(() {
      _searchQuery = query;
      _filteredCategories = _categories
          .where((c) =>
          c.name.toLowerCase().contains(query.toLowerCase().trim()))
          .toList();
    });
  }

  Future<void> _showRandomMeal() async {
    setState(() {
      _isRandomLoading = true;
    });

    final Meal? randomMeal = await _apiService.fetchRandomMeal();

    setState(() {
      _isRandomLoading = false;
    });

    if (randomMeal != null && mounted) {
      Navigator.pushNamed(
        context,
        '/meal-details',
        arguments: randomMeal,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            tooltip: 'Омилени рецепти',
            onPressed: () {
              Navigator.pushNamed(context, '/favorites');
            },
          ),
          IconButton(
            onPressed: _isRandomLoading ? null : _showRandomMeal,
            icon: _isRandomLoading
                ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
                : const Icon(Icons.open_in_new),
            tooltip: 'Random meal of the day',
          ),
        ],
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
                hintText: 'Search categories...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: _filterCategories,
            ),
          ),
          Expanded(
            child: CategoryGrid(categories: _filteredCategories),
          ),
        ],
      ),
    );
  }
}
