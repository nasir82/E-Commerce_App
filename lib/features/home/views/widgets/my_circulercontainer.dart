import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/utils/constants/color.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';

class MyCirculerContainer extends StatelessWidget {
  const MyCirculerContainer(
      {super.key,
      this.child,
      this.width,
      this.height,
      this.radius = Sizes.cardRadiusLg,
      this.padding,
      this.margin,
      this.backgroundColor = MyColor.white,
      this.showBorder=false,
      this.borderColor = MyColor.borderPrimaryColor
      });

  final double? width;
  final double? height;
  final double radius;
  final EdgeInsetsGeometry? padding;
  final Widget? child;
  final Color backgroundColor;
  final Color borderColor;
  final EdgeInsetsGeometry? margin;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      border: showBorder ? Border.all(color: borderColor):null,
          
      color: backgroundColor),
      child: child,
    );
  }
}
