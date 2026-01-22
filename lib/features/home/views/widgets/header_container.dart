import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/custom_shapes/custom_cliper.dart';
import 'package:flutter_e_commerce_app/features/home/views/widgets/my_circulercontainer.dart';
import 'package:flutter_e_commerce_app/utils/constants/color.dart';

class HeaderContainer extends StatelessWidget {
  const HeaderContainer({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return CustomShapeClipPath(
      child: Container(
        color: MyColor.primaryColor,
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            Positioned(
                top: -150,
                right: -250,
                child: MyCirculerContainer(
                  backgroundColor: MyColor.textWhite.withOpacity(0.3),
                )),
            Positioned(
                top: 100,
                right: -300,
                child: MyCirculerContainer(
                  backgroundColor: MyColor.textWhite.withOpacity(0.3),
                )),
            child,
          ],
        ),
      ),
    );
  }
}
