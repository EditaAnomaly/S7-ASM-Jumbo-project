import 'package:flutter/material.dart';
// import 'package:jumbo_app_flutter/models/allergen.dart';
// import 'package:jumbo_app_flutter/models/product.dart';
// import 'package:jumbo_app_flutter/services/product.service.dart';

class CataloguePage extends StatefulWidget {
  const CataloguePage({super.key});
  @override
  State<CataloguePage> createState() => _CataloguePageState();
}

class _CataloguePageState extends State<CataloguePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalogue'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      // body
    );
  }
}
