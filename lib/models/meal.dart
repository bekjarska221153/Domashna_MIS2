class Meal {
  final String id;
  final String name;
  final String category;
  final String thumbnail;
  final String instructions;
  final List<String> ingredients;
  final String youtubeUrl;

  Meal({
    required this.id,
    required this.name,
    required this.category,
    required this.thumbnail,
    required this.instructions,
    required this.ingredients,
    required this.youtubeUrl,
  });


  factory Meal.fromDetailJson(Map<String, dynamic> json) {
    final List<String> ingredients = [];

    for (int i = 1; i <= 20; i++) {
      final ing = json['strIngredient$i'];
      final measure = json['strMeasure$i'];
      if (ing != null && ing.toString().trim().isNotEmpty) {
        final String m = (measure ?? '').toString().trim();
        final String line =
            (m.isNotEmpty ? '$m ' : '') + ing.toString().trim();
        ingredients.add(line);
      }
    }

    return Meal(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? '',
      category: json['strCategory'] ?? '',
      thumbnail: json['strMealThumb'] ?? '',
      instructions: json['strInstructions'] ?? '',
      ingredients: ingredients,
      youtubeUrl: json['strYoutube'] ?? '',
    );
  }
}
