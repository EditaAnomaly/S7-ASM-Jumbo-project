import 'package:flutter/material.dart';
import 'package:jumbo_app_flutter/models/preference_option.dart';

class RoundedOutlinedButton extends StatelessWidget {
  final PreferenceOption item;
  final Function(PreferenceOption) callback;

  const RoundedOutlinedButton(this.item, this.callback, {super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        callback(item);
      },
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        side: const BorderSide(
          color: Color(0xffEEB717),
        ),
        foregroundColor: Colors.black,
      ),
      child: Text(item.value),
    );
  }
}
