import 'package:flutter/material.dart';
import 'package:jumbo_app_flutter/models/basket.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thank you!'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('images/checkmark.png'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Your payment has been processed.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Use the barcode to exit.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xffEEB717)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: const BorderSide(
                      color: Color(0xffEEB717),
                    ),
                  ),
                ),
              ),
              onPressed: () {
                Basket.items.clear();
                Navigator.pop(context);
              },
              child: const Text(
                'Back to cart',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 30),
            const Image(
              image: AssetImage('images/byecode.png'),
            ),
          ],
        ),
      ),
    );
  }
}
