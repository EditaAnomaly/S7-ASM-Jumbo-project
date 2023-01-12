import 'package:flutter/material.dart';

class FloatingScanButton extends StatelessWidget {
  final Function onTap;

  const FloatingScanButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        onTap();
      },
      backgroundColor: const Color(0xffEEB717),
      tooltip: 'Scan',
      foregroundColor: Colors.black,
      child: Image.asset(
        'images/scanbar.png',
        width: 30,
        height: 30,
        fit: BoxFit.fill,
      ),
    );
  }
}
