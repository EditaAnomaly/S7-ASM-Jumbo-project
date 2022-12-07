import 'package:flutter/material.dart';

class PanelTabBar extends StatelessWidget {
  const PanelTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      labelColor: Color(0xffEEB717),
      indicatorColor: Color(0xffEEB717),
      unselectedLabelColor: Colors.black,
      tabs: [
        Tab(
          child: Text(
            "Basket",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Tab(
          child: Text(
            "Shopping list",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
