import 'package:flutter/material.dart';

class PreferenceSelector extends StatefulWidget {
  const PreferenceSelector({super.key});

  @override
  State<StatefulWidget> createState() => _PreferenceSelectorState();
}

class _PreferenceSelectorState extends State<PreferenceSelector> {
  List<String> preferences = [
    "Pinda's",
    "test",
    "test",
    "test",
    "test",
    "test"
  ];

  _openTextField() {
    print("HOI");
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for (var item in preferences)
          Container(
            margin: const EdgeInsets.only(right: 8.0),
            child: OutlinedButton(
              onPressed: () {
                print(item);
              },
              style: OutlinedButton.styleFrom(
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
          ),
          onPressed: () {
            _openTextField();
          },
          child: const Icon(
            Icons.add,
            size: 20.0,
          ),
        ),
      ],
    );

    // [
    // TextButton(
    //   style: TextButton.styleFrom(
    //     shape: const CircleBorder(),
    //     foregroundColor: Colors.black,
    //     backgroundColor: const Color(0xffEEB717),
    //   ),
    //   onPressed: () {
    //     _openTextField();
    //   },
    //   child: const Icon(
    //     Icons.add,
    //     size: 30.0,
    //   ),
    // ),
    // ],
  }
}
