import 'package:jumbo_app_flutter/models/preference_option.dart';

class PreferenceService {
  static final List<String> allergens = ["Pinda's"];

  static final List<PreferenceOption> options = [
    PreferenceOption("Pinda's", true),
    PreferenceOption("Melk", false),
    PreferenceOption("Cashewnoten", false),
    PreferenceOption("Tarwe", false),
    PreferenceOption("Sesam", false),
    PreferenceOption("Noten", false),
    PreferenceOption("Mosterd", false),
    PreferenceOption("Gerst", false),
    PreferenceOption("Selderij", false),
    PreferenceOption("Eieren", false),
    PreferenceOption("Soja", false),
  ];

  setAllergen(String allergen) {
    allergens.add(allergen);
  }

  removeAllergen(String allergen) {
    allergens.remove(allergen);
  }
}
