import 'package:jumbo_app_flutter/models/preference_option.dart';

class PreferenceService {
  static final List<String> allergens = [];

  static final List<PreferenceOption> options = [
    PreferenceOption("Pinda's"),
    PreferenceOption("Melk"),
    PreferenceOption("Cashewnoten"),
    PreferenceOption("Tarwe"),
    PreferenceOption("Sesam"),
    PreferenceOption("Noten"),
    PreferenceOption("Mosterd"),
    PreferenceOption("Gerst"),
    PreferenceOption("Selderij"),
    PreferenceOption("Eieren"),
    PreferenceOption("Soja"),
  ];

  setAllergen(String allergen) {
    allergens.add(allergen);
  }

  removeAllergen(String allergen) {
    allergens.remove(allergen);
  }
}
