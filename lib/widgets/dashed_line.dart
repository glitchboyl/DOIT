import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class DashedLine extends StatelessWidget {
  @override
  Widget build(context) => DottedLine(
        dashLength: MEAS.dashLength,
        dashGapLength: MEAS.dashGapLength,
        direction: Axis.vertical,
        dashColor: Styles.DashedLineColor,
        lineThickness: MEAS.lineThickness,
        dashRadius: MEAS.dashRadius,
      );
}
