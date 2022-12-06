import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:jumbo_app_flutter/models/navigation/destination.dart';

class NavigationService {
  final ref = FirebaseDatabase.instance.ref();

  Future<Destination> fetchDestination(String destination) async {
    final snapshot = await ref.child('destination/$destination').get();

    final json = jsonDecode(jsonEncode(snapshot.value));

    return Destination.fromJson(json);
  }
}
