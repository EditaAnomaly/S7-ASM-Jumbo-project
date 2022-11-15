import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/bottom_nav_cubit.dart';
import 'pages/basket_page.dart';
import 'pages/catalogue_page.dart';
import 'pages/profile_page.dart';

// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:jumbo_app_flutter/models/allergen.dart';
// import 'package:jumbo_app_flutter/models/product.dart';
// import 'package:jumbo_app_flutter/services/product.service.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => BottomNavCubit(),
        child: MaterialApp(
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: const MainPage(),
        ));
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _pageNavigation = [
    BasketPage(),
    CataloguePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, state) {
        return Scaffold(
          body: _buildBody(state),
          bottomNavigationBar: _buildBottomNav(),
        );
      },
    );
  }

  Widget _buildBody(int index) {
    return _pageNavigation.elementAt(index);
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: context.read<BottomNavCubit>().state,
      type: BottomNavigationBarType.fixed,
      onTap: _getChangeBottomNav,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket_outlined), label: "Basket"),
        BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined), label: "Catalogue"),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: "Profile"),
      ],
      iconSize: 33,
      unselectedFontSize: 13,
      selectedFontSize: 13,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xffEEB717),
    );
  }

  void _getChangeBottomNav(int index) {
    context.read<BottomNavCubit>().updateIndex(index);
  }
}

// class _MainPageState extends State<MainPage> {
//   final ProductService productService = ProductService();
//   late Product product;
//   late List<Allergen> warnings;
//   int _selectedBottomNavIndex = 0;

//   _openBarcodeScanner() async {
//     String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
//         "#000000", "Cancel", true, ScanMode.BARCODE);

//     product = await productService.scan(barcodeScanRes);

//     warnings = productService.getWarnings(product);

//     if (warnings.isEmpty) return;

//     _alertAboutProduct(product, warnings);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text('Hello Lisa!'),
//         backgroundColor: Colors.amber,
//       ),
//       body: IndexedStack(),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _openBarcodeScanner,
//         backgroundColor: const Color(0xffEEB717),
//         tooltip: 'Scan',
//         child: const Image(
//           image: AssetImage('images/barcode.png'),
//         ),
//       ),
//     );
//   }

//   _alertAboutProduct(Product product, List<Allergen> warnings) {
//     showDialog(
//       context: context, barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Column(
//             //mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: const [
//               Image(
//                 image: AssetImage('images/warningsmol.png'),
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'Product Warning',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 20),
//               Text(
//                   'Pay attention! The Product contains the following dangerous ingredients:')
//             ],
//           ),
//           content: SizedBox(
//             width: double.maxFinite,
//             height: 500,
//             child: ListView.builder(
//               shrinkWrap: true,
//               itemCount: warnings.length,
//               itemBuilder: (context, index) {
//                 return ListTile(title: Text(warnings[index].message));
//               },
//             ),
//           ),
//           actions: [
//             TextButton(
//               style: TextButton.styleFrom(
//                 foregroundColor: Colors.black,
//                 backgroundColor: const Color(0xffEEB717),
//                 //padding: const EdgeInsets.all(16.0),
//                 textStyle: const TextStyle(fontSize: 20),
//               ),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Add anyway'),
//             ),
//             OutlinedButton(
//                 style: OutlinedButton.styleFrom(
//                   side: const BorderSide(
//                     width: 1.0,
//                     color: Color(0xffEEB717),
//                   ),
//                   textStyle: const TextStyle(fontSize: 20),
//                 ),
//                 child: const Text('Cancel'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 }),
//           ],
//           actionsAlignment: MainAxisAlignment.spaceEvenly,
//         );
//       },
//     );
//   }
// }
