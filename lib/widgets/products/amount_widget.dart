import 'package:flutter/material.dart';

class AmountWidget extends StatelessWidget {
  final int amount;
  final Function(String) callback;

  const AmountWidget(this.amount, this.callback, {super.key});

  _remove() {
    callback("remove");
  }

  _add() {
    callback("add");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: const Color(0xffEEB717),
          style: BorderStyle.solid,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AmountButton(Icons.remove, _remove),
          Text("$amount"),
          AmountButton(Icons.add, _add)
        ],
      ),
    );
  }
}

class AmountButton extends StatelessWidget {
  final IconData icon;
  final Function callback;

  const AmountButton(this.icon, this.callback, {super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        callback();
      },
      icon: Icon(
        icon,
        size: 15,
      ),
      constraints: const BoxConstraints(minWidth: 36),
      padding: EdgeInsets.zero,
    );
  }
}
