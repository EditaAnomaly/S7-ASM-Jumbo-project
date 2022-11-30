class Node {
  late String type;
  late double xOffset;
  late double yOffset;
  late double zOffset;

  Node({
    required this.type,
    required this.xOffset,
    required this.yOffset,
    required this.zOffset,
  });

  factory Node.fromJson(Map<String, dynamic> json) {
    return Node(
      type: json['type'],
      xOffset: json['x_offset'],
      yOffset: json['y_offset'],
      zOffset: json['z_offset'],
    );
  }
}
