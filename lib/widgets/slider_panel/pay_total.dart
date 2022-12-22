import 'package:flutter/material.dart';
import 'package:jumbo_app_flutter/models/products/price.dart';
import 'package:jumbo_app_flutter/widgets/products/price_text.dart';

class PayTotal extends StatelessWidget {
  const PayTotal(this.total, this.onPay, {super.key});

  final Price total;
  final Function() onPay;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPay(),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        backgroundColor: const Color(0xffEEB717),
        foregroundColor: Colors.black,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Pay total",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          PriceText(total),
        ],
      ),
    );
  }
}
