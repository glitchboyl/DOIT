import 'package:flutter/material.dart';

class FABLocation extends FloatingActionButtonLocation {
  FABLocation({
    required this.location,
    this.offsetX = 0,
    this.offsetY = 0,
  });
  final FloatingActionButtonLocation location;
  final double offsetX;
  final double offsetY;

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    Offset offset = location.getOffset(scaffoldGeometry);
    return Offset(
      offset.dx +
          offsetX +
          kFloatingActionButtonMargin +
          kMiniButtonOffsetAdjustment,
      offset.dy +
          offsetY +
          kFloatingActionButtonMargin +
          kMiniButtonOffsetAdjustment,
    );
  }
}
