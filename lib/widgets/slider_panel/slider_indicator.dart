import 'package:flutter/material.dart';

class SliderIndicator extends StatelessWidget {
  const SliderIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: 4,
      decoration: BoxDecoration(
        color: Colors.grey,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    );
  }
}
