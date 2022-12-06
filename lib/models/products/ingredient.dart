class Ingredient {
  final String name;
  final bool containsAllergens;
  // final List<any> hightlights;

  Ingredient({
    required this.name,
    required this.containsAllergens,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'],
      containsAllergens: json['containsAllergens'],
    );
  }
}
