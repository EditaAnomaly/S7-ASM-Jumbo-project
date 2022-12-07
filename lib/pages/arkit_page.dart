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

        // for (Node node in destination.nodes) {
        // var arrowNode = createNode(node);
        // arkitController.add(arrowNode);
        // }
        destination.nodes.asMap().forEach((index, current) {
          var next = destination.nodes[index + 1];
          var arrowNode = createNode(current, next);
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

    Matrix4 nextTranslation = Matrix4.identity();
    nextTranslation.setColumn(
      3,
      Vector4(
        nextNode.xOffset,
        nextNode.yOffset,
        nextNode.zOffset,
        1,
      ),
    );

    Matrix4 nextNodeTransform = arrowNode.transform * nextTranslation;

    arrowNode.eulerAngles = Vector3(
      nextNodeTransform.row3.x,
      nextNodeTransform.row3.y,
      nextNodeTransform.row3.z,
    );

    return arrowNode;
  }
}
