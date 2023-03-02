import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SVGIcon extends StatelessWidget {
  const SVGIcon({
    super.key,
    required this.icon,
    this.width,
    this.height,
  });

  final String icon;
  final double? width;
  final double? height;

  @override
  Widget build(context) => SizedBox(
        width: width,
        height: height,
        child: Center(
          child: SvgPicture.asset(
            icon,
            width: width,
            height: height,
            fit: BoxFit.cover,
          ),
        ),
      );
}
