import 'package:flutter/foundation.dart';
import '../models/meal.dart';

class FavoritesService extends ChangeNotifier {
  final List<Meal> _favorites = [];

  List<Meal> get favorites => List.unmodifiable(_favorites);

  bool isFavorite(Meal meal) {
    return _favorites.any((m) => m.id == meal.id);
  }

  void toggleFavorite(Meal meal) {
    final index = _favorites.indexWhere((m) => m.id == meal.id);
    if (index >= 0) {
      _favorites.removeAt(index);
    } else {
      _favorites.add(meal);
    }
    notifyListeners();
  }
}
