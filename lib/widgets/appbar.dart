import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {Key? key,
      required this.leading,
      required this.pageName,
      this.amount,
      required this.appBar})
      : super(key: key);
  final String leading;
  final String pageName;
  final int? amount;
  final AppBar appBar;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: <Widget>[
          Text(
            "$leading ",
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
          Text(
            pageName.toLowerCase(),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (amount != null) ...{
            Text(
              " ($amount)",
              style: const TextStyle(
                fontSize: 24,
                color: Colors.grey,
              ),
            ),
          },
        ],
      ),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      centerTitle: false,
      leadingWidth: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
