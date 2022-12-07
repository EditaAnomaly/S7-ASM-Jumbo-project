import 'package:flutter/material.dart';
import 'package:jumbo_app_flutter/models/shopping_list.dart';

class CategoryHeader extends StatelessWidget {
  const CategoryHeader(this.category, this.callback, {super.key});

  final Category category;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: const Color(0xFFD1D1D1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(category.name),
          TextButton(
            onPressed: () {
              callback(category);
            },
            style: TextButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: -2),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Text(
                    "Guide me",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(
                  Icons.navigation,
                  size: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
