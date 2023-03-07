import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SVGIcon extends StatelessWidget {
  const SVGIcon(
    this.icon, {
    super.key,
    this.width,
    this.height,
    this.color,
  });

  final String icon;
  final double? width;
  final double? height;
  final Color? color;

  @override
  Widget build(context) => SizedBox(
        width: width,
        height: height,
        child: Center(
          child: SvgPicture.asset(
            icon,
            colorFilter: color != null
                ? ColorFilter.mode(color!, BlendMode.srcIn)
                : null,
            width: width,
            height: height,
            fit: BoxFit.cover,
          ),
        ),
      );
}
