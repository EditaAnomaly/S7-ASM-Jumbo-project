import 'package:flutter/material.dart';
import 'package:jumbo_app_flutter/models/preference_option.dart';
import 'package:jumbo_app_flutter/services/preference.service.dart';
import 'package:jumbo_app_flutter/widgets/preferences/buttons/rounded_outlined_button.dart';
import 'package:jumbo_app_flutter/widgets/preferences/buttons/rounded_text_button.dart';

class PreferenceDialog extends StatefulWidget {
  final List<PreferenceOption> options;
  final Function(List<PreferenceOption>) callback;

  const PreferenceDialog(this.options, this.callback, {super.key});

  @override
  State<StatefulWidget> createState() => _PreferenceDialogSate();
}

class _PreferenceDialogSate extends State<PreferenceDialog> {
  _changeItemState(PreferenceOption item) {
    setState(() {
      item.isActive = !item.isActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const Border(
          left: BorderSide(width: 6.0, color: Color((0xffEEB717)))),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text(
            "Choose allergens",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: SizedBox(
          child: Wrap(
        children: [
          for (var item in PreferenceService.options)
            Container(
              margin: const EdgeInsets.only(right: 8.0, bottom: 8.0),
              child: item.isActive
                  ? RoundedTextButton(item, _changeItemState)
                  : RoundedOutlinedButton(item, _changeItemState),
            ),
        ],
      )),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: const Color(0xffEEB717),
            fixedSize: const Size(70, 45),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            textStyle: const TextStyle(fontSize: 20),
          ),
          onPressed: () {
            widget.callback(widget.options);
            Navigator.of(context).pop();
          },
          child: const Text("Save",
              style: TextStyle(fontFamily: 'Jumbo', fontSize: 18)),
        ),
        TextButton(
            style: OutlinedButton.styleFrom(
              fixedSize: const Size(90, 45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              side: const BorderSide(
                color: Color(0xffEEB717),
              ),
              textStyle: const TextStyle(fontSize: 18),
            ),
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.black, fontFamily: 'Jumbo'),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            })
      ],
      actionsAlignment: MainAxisAlignment.spaceEvenly,
    );
  }
}
