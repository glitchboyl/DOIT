import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class DashedLine extends StatelessWidget {
  const DashedLine({super.key});
  @override
  Widget build(context) => DottedLine(
        dashLength: MEAS.dashLength,
        dashGapLength: MEAS.dashGapLength,
        direction: Axis.vertical,
        dashColor: Theme.of(context).colorScheme.deactivedColor,
        lineThickness: MEAS.lineThickness,
        dashRadius: MEAS.dashRadius,
      );
}
