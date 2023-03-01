import 'package:flutter/material.dart';

class FABAnimator extends FloatingActionButtonAnimator {
  @override
  Offset getOffset(
      {required Offset begin, required Offset end, required double progress}) {
    // return Offset(begin.dx + (end.dx - begin.dx) * progress,
    //     begin.dy + (end.dy - begin.dy) * progress);
    return end;
  }

  @override
  Animation<double> getRotationAnimation({required Animation<double> parent}) =>
      Tween<double>(begin: 1, end: 1).animate(parent);

  @override
  Animation<double> getScaleAnimation({required Animation<double> parent}) =>
      Tween<double>(begin: 1, end: 1).animate(parent);
}
