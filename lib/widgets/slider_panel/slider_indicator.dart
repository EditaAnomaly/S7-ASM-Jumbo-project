import 'package:flutter/material.dart';

class SliderIndicator extends StatelessWidget {
  const SliderIndicator(this.callback, {super.key});
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        callback();
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
        child: Container(
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
        ),
      ),
    );
  }
}
