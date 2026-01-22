import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/custom_shapes/curve_edges.dart';

class CustomShapeClipPath extends StatelessWidget {
  const CustomShapeClipPath({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: MyCarveEdges(), child: child);
  }
}