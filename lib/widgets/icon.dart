import 'package:doit/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class IconBuilder extends StatelessWidget {
  const IconBuilder({
    super.key,
    this.width,
    this.height,
    this.margin,
    this.borderRadius,
    this.color,
    required this.icon,
    this.iconWidth,
    this.iconHeight,
  });

  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;
  final Color? color;
  final String icon;
  final double? iconWidth;
  final double? iconHeight;
  
  @override
  Widget build(BuildContext context) => Container(
        width: width,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: color,
        ),
        child: SVGIcon(
          icon: icon,
          width: iconWidth,
          height: iconHeight,
        ),
      );
}
