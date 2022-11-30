import 'package:jumbo_app_flutter/models/navigation/node.dart';

class Destination {
  late String destination;
  late String beaconName;
  late int nodeCount;
  late List<Node> nodes;

  Destination({
    required this.destination,
    required this.beaconName,
    required this.nodeCount,
    required this.nodes,
  });

  factory Destination.fromJson(Map<dynamic, dynamic> json) {
    return Destination(
      destination: json['destination'],
      beaconName: json['beacon_name'],
      nodeCount: json['node_count'],
      nodes: List<Node>.from(json['nodes']['index'].map(
        (node) => Node.fromJson(node),
      )),
    );
  }
}
