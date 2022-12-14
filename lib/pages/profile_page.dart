import 'package:flutter/material.dart';
import 'package:jumbo_app_flutter/widgets/preferences/preference_selector.dart';
import 'package:jumbo_app_flutter/widgets/appbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar(leading: "Your", pageName: "Profile", appBar: AppBar()),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [Avatar(), SizedBox(height: 30), CollapseTile()],
        ),
      ),
    );
  }
}

class Avatar extends StatelessWidget {
  const Avatar({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 20.0, bottom: 10.0),
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              border: Border.all(width: 5, color: const Color(0xffEEB717)),
              borderRadius: BorderRadius.circular(140),
            ),
            child: const CircleAvatar(
              radius: 120,
              backgroundImage: AssetImage("images/avatar.png"),
            ),
          ),
          const Text(
            'Your name',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      )
    ]);
  }
}

class CollapseTile extends StatefulWidget {
  const CollapseTile({super.key});

  @override
  State<CollapseTile> createState() => _CollapseTileState();
}

class _CollapseTileState extends State<CollapseTile> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: const <Widget>[
            ExpansionTile(
              textColor: Color(0xffEEB717),
              iconColor: Color(0xffEEB717),
              collapsedTextColor: Colors.black,
              collapsedIconColor: Colors.black,
              expandedAlignment: Alignment.centerLeft,
              childrenPadding: EdgeInsets.only(left: 18.0, bottom: 20),
              title: Text('Diet preferences'),
              children: [PreferenceSelector()],
            ),
            ExpansionTile(
              textColor: Color(0xffEEB717),
              iconColor: Color(0xffEEB717),
              collapsedTextColor: Colors.black,
              collapsedIconColor: Colors.black,
              expandedAlignment: Alignment.centerLeft,
              childrenPadding: EdgeInsets.only(left: 18.0, bottom: 20),
              title: Text('Profile settings'),
              children: [Text("Something here")],
            ),
            ExpansionTile(
              textColor: Color(0xffEEB717),
              iconColor: Color(0xffEEB717),
              collapsedTextColor: Colors.black,
              collapsedIconColor: Colors.black,
              expandedAlignment: Alignment.centerLeft,
              childrenPadding: EdgeInsets.only(left: 18.0, bottom: 20),
              title: Text('App settings'),
              children: [Text("Something here")],
            ),
          ],
        ),
      ),
    );
  }
}
