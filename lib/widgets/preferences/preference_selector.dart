import 'package:flutter/material.dart';
import 'package:jumbo_app_flutter/models/preference_option.dart';
import 'package:jumbo_app_flutter/services/preference.service.dart';
import 'package:jumbo_app_flutter/widgets/preferences/preference_dialog.dart';
import 'package:jumbo_app_flutter/widgets/products/first_use_disclaimer.dart';

bool firstUse = true;

class PreferenceSelector extends StatefulWidget {
  const PreferenceSelector({super.key});

  @override
  State<StatefulWidget> createState() => _PreferenceSelectorState();
}

class _PreferenceSelectorState extends State<PreferenceSelector> {
  final PreferenceService service = PreferenceService();
  final List<String> allergens = List.from(PreferenceService.allergens);

  _clearPreferences() {
    setState(() {
      PreferenceService.allergens.clear();
      allergens.clear();
    });
  }

  _addPreference(String preference) {
    setState(() {
      service.setAllergen(preference);
      allergens.add(preference);
    });
  }

  _removePreference(item) {
    setState(() {
      service.removeAllergen(item);
      allergens.remove(item);
    });
  }

  _saveOptions(List<PreferenceOption> options) {
    _clearPreferences();

    for (var element in options) {
      if (element.isActive) {
        _addPreference(element.value);
      }
    }
  }

  _openOptionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PreferenceDialog(PreferenceService.options, _saveOptions);
      },
    );
  }

  _openFirstUseDisclaimer() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FirstUseDisclaimer(_openOptionDialog);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Text(
            "Allergies",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Wrap(
          children: [
            for (var item in allergens)
              Container(
                margin: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                child: OutlinedButton(
                  onPressed: () {
                    if (firstUse == true) {
                      _openFirstUseDisclaimer();
                      firstUse = false;
                    } else {
                      _openOptionDialog();
                    }
                    // _openOptionDialog();
                  },
                  style: OutlinedButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    side: const BorderSide(
                      color: Color(0xffEEB717),
                    ),
                    foregroundColor: Colors.black,
                  ),
                  child: Text(item),
                ),
              ),
            TextButton(
              style: TextButton.styleFrom(
                shape: const CircleBorder(),
                foregroundColor: Colors.black,
                backgroundColor: const Color(0xffEEB717),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () {
                // _openOptionDialog();
                if (firstUse == true) {
                  _openFirstUseDisclaimer();
                  firstUse = false;
                } else {
                  _openOptionDialog();
                }
              },
              child: const Icon(
                Icons.add,
                size: 20.0,
              ),
            ),
          ],
        )
      ],
    );
  }
}
