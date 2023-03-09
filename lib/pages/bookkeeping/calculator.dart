import 'dart:ui';

import 'package:doit/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:doit/widgets/text.dart';
import 'package:doit/widgets/interactive_button.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

const calculatorCells = [
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '0',
  '.',
  'BACKSPACE'
];

class Calculator extends StatelessWidget {
  const Calculator({
    super.key,
    required this.onInput,
  });
  final void Function(String) onInput;

  @override
  Widget build(BuildContext context) => Container(
        height: 222,
        margin: EdgeInsets.only(top: 10, bottom: 12),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 10,
            childAspectRatio:
                (MediaQuery.of(context).size.width - 56) / 3 / (192 / 4),
          ),
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: calculatorCells.length,
          itemBuilder: (context, i) => InteractiveButton(
            color: Styles.RegularBaseColor,
            activedColor: Styles.DeactivedColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.all(Radius.circular(8)),
            ),
            child: calculatorCells[i] == 'BACKSPACE'
                ? SVGIcon(
                    'assets/images/backspace.svg',
                    width: MEAS.itemOperationIconLength,
                    height: MEAS.itemOperationIconLength,
                  )
                : TextBuilder(
                    calculatorCells[i],
                    color: Styles.PrimaryTextColor,
                    fontSize: Styles.largeTextSize,
                    lineHeight: Styles.largeTextLineHeight,
                    fontWeight: FontWeight.bold,
                  ),
            onPressed: () => onInput(calculatorCells[i]),
          ),
        ),
      );
}
