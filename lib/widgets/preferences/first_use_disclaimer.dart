import 'package:flutter/material.dart';

class FirstUseDisclaimer extends StatelessWidget {
  const FirstUseDisclaimer(this.callback, {super.key});
  final Function() callback;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape:
          const Border(left: BorderSide(width: 6.0, color: Color(0xffEEB717))),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text(
            'Use with caution',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            'Use this app with caution. Nothing in this app should be taken as health advice. Always double-check the ingredients!',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            callback();
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            backgroundColor: const Color(0xffEEB717),
            foregroundColor: Colors.black,
          ),
          child: const Text('Acknowledge'),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            side: const BorderSide(
              color: Color(0xffEEB717),
            ),
            foregroundColor: Colors.black,
          ),
          child: const Text("Cancel (close)"),
        ),
      ],
      actionsAlignment: MainAxisAlignment.spaceEvenly,
    );
  }
}
