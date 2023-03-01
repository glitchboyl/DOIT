import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SVGIcon extends StatelessWidget {
  const SVGIcon({
    Key? key,
    required this.icon,
    this.width,
    this.height,
  }) : super(key: key);

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
            fit: BoxFit.cover,
          ),
        ),
      );
}
