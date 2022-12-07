import 'package:flutter/material.dart';

class FirstUseDisclaimer extends StatelessWidget {
  const FirstUseDisclaimer({super.key});

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
          )
        ],
      ),
      content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: []),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: const Color(0xffEEB717),
            textStyle: const TextStyle(fontSize: 16),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Acknowledge'),
        ),
        TextButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                color: Color(0xffC8C8C8),
              ),
              textStyle: const TextStyle(fontSize: 16),
            ),
            child: const Text('Cancel (close)',
                style: TextStyle(color: Colors.black)),
            onPressed: () {
              Navigator.of(context).pop();
            })
      ],
      actionsAlignment: MainAxisAlignment.spaceEvenly,
    );
  }
}
