import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget svg(String assetName, {double? width, double? height}) => Center(
      child: SvgPicture.asset(
        assetName,
        width: width,
        height: height,
        fit: BoxFit.scaleDown,
      ),
    );
