import 'dart:math';

import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:jumbo_app_flutter/models/navigation/destination.dart';
import 'package:jumbo_app_flutter/models/navigation/node.dart';
import 'package:jumbo_app_flutter/models/shopping_list.dart';
import 'package:jumbo_app_flutter/services/navigation.service.dart';
import 'package:jumbo_app_flutter/widgets/appbar.dart';
import 'package:vector_math/vector_math_64.dart';

class ARNavigationWidget extends StatefulWidget {
  final Category category;
  const ARNavigationWidget({super.key, required this.category});

  @override
  State<ARNavigationWidget> createState() => _ARNavigationWidgetState();
}

class _ARNavigationWidgetState extends State<ARNavigationWidget> {
  late ARKitController arkitController;
  late Matrix4 lastNodeTransform;

  final navigationService = NavigationService();
  late Destination destination;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: "Finding",
        pageName: widget.category.name,
        appBar: AppBar(),
      ),
      body: ARKitSceneView(
        onARKitViewCreated: onARKitViewCreated,
        detectionImagesGroupName: "AR Resources",
      ),
    );
  }

  void onARKitViewCreated(ARKitController arkitController) async {
    this.arkitController = arkitController;

    Destination destination =
        await navigationService.fetchDestination(widget.category.destination);

    arkitController.onAddNodeForAnchor = (anchor) {
      if (anchor is ARKitImageAnchor) {
        lastNodeTransform = anchor.transform;

        destination.nodes.asMap().forEach((currentIndex, currentNode) {
          var nextIndex = currentIndex + 1;
          var nextNode = destination.nodes[nextIndex];
          var arrowNode = createNode(currentNode, nextNode);
          arkitController.add(arrowNode);
        });
      }
    };
  }

  createNode(Node targetNode, Node nextNode) {
    final arrowNode = ARKitReferenceNode(
      url: "Models.scnassets/arrowModel.dae",
    );

    Matrix4 targetTranslation = Matrix4.identity();
    targetTranslation.setColumn(
      3,
      Vector4(
        targetNode.xOffset,
        targetNode.yOffset,
        targetNode.zOffset,
        1,
      ),
    );

    arrowNode.transform = lastNodeTransform * targetTranslation;
    lastNodeTransform = arrowNode.transform;

    // set rotation
    double zRadian = atan2(nextNode.yOffset, nextNode.xOffset);
    arrowNode.eulerAngles = Vector3(0, 0, zRadian);

    return arrowNode;
  }

  void lookAt(ARKitNode node, Vector3 targetPosition) {
    Vector3 position = node.position;
    Vector3 direction = targetPosition - position;
    direction.normalize();
    Vector3 up = Vector3(0, 1, 0);
    Vector3 forward = direction;
    Vector3 right = direction.cross(up);
    up = right.cross(forward);
    final rotationMatrix = Matrix3(right.x, right.y, right.z, up.x, up.y, up.z,
        forward.x, forward.y, forward.z);
    node.rotation = rotationMatrix;
  }
}
