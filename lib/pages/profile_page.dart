import 'package:flutter/material.dart';
import 'package:jumbo_app_flutter/widgets/preferences/preference_selector.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: const <Widget>[
          Text('Your ',
              style: TextStyle(
                fontSize: 24,
              )),
          Text(
            'Profile',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ]),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: false,
        leadingWidth: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            PreferenceSelector(),
          ],
        ),
      ),
    );
  }
}
