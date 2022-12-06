class Allergen {
  final String message;
  final String allergen;
  final AllergenType type;

  Allergen({
    required this.message,
    required this.allergen,
    required this.type,
  });

  factory Allergen.fromString(String message) {
    var words = message.trim().split(' ');
    String allergen = words[words.length - 1];

    AllergenType type = AllergenType.doesNotContain;
    if (message.contains('Kan het volgende bevatten')) {
      type = AllergenType.couldContain;
    } else if (message.contains('Bevat')) {
      type = AllergenType.contains;
    }

    return Allergen(message: message, allergen: allergen, type: type);
  }
}

enum AllergenType {
  contains,
  couldContain,
  doesNotContain,
}
