import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:jumbo_app_flutter/models/allergen.dart';
import 'package:jumbo_app_flutter/models/product.dart';
import 'package:jumbo_app_flutter/services/product.service.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ProductService productService = ProductService();
  late Product product;
  late List<Allergen> warnings;
  int _selectedBottomNavIndex = 0;

  // Test pages
  static const List<Widget> _pages = <Widget>[
    Icon(
      Icons.shopping_basket_outlined,
      size: 150,
    ),
    Icon(
      Icons.search_outlined,
      size: 150,
    ),
    Icon(
      Icons.person_outline,
      size: 150,
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _selectedBottomNavIndex = index;
    });
  }

  _openBarcodeScanner() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#000000", "Cancel", true, ScanMode.BARCODE);

    product = await productService.scan(barcodeScanRes);

    warnings = productService.getWarnings(product);

    if (warnings.isEmpty) return;

    _alertAboutProduct(product, warnings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Hello Lisa!'),
        backgroundColor: Colors.amber,
      ),
      body: IndexedStack(
        // This method remembers the open page.
        index: _selectedBottomNavIndex,
        children: _pages,
      ),
      // body: Center(
      //   child: _pages.elementAt(_selectedBottomNavIndex),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openBarcodeScanner,
        backgroundColor: const Color(0xffEEB717),
        tooltip: 'Scan',
        child: const Image(
          image: AssetImage('images/barcode.png'),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black, offset: Offset(0, 0)),
          ],
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket_outlined),
              label: 'Basket',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              label: 'Catalogue',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
          iconSize: 33,
          unselectedFontSize: 13,
          selectedFontSize: 13,
          backgroundColor: Colors.white,
          currentIndex: _selectedBottomNavIndex,
          onTap: _onBottomNavTapped,
          selectedItemColor: const Color(0xffEEB717),
        ),
      ),
    );
  }

  _alertAboutProduct(Product product, List<Allergen> warnings) {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Image(
                image: AssetImage('images/warningsmol.png'),
              ),
              SizedBox(height: 20),
              Text(
                'Product Warning',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                  'Pay attention! The Product contains the following dangerous ingredients:')
            ],
          ),
          content: SizedBox(
            width: double.maxFinite,
            height: 500,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: warnings.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(warnings[index].message));
              },
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: const Color(0xffEEB717),
                //padding: const EdgeInsets.all(16.0),
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Add anyway'),
            ),
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    width: 1.0,
                    color: Color(0xffEEB717),
                  ),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
          actionsAlignment: MainAxisAlignment.spaceEvenly,
        );
      },
    );
  }
}
