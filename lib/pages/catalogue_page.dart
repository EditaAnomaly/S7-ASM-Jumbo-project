import 'package:flutter/material.dart';
import 'package:jumbo_app_flutter/widgets/appbar.dart';

class CataloguePage extends StatefulWidget {
  const CataloguePage({super.key});
  @override
  State<CataloguePage> createState() => _CataloguePageState();
}

class _CataloguePageState extends State<CataloguePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          leading: "Search", pageName: "Catalogue", appBar: AppBar()),
      // body
    );
  }
}
