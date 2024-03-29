import 'package:doit/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:doit/widgets/interactive_button.dart';
import 'package:doit/constants/icons.dart';
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
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
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
          color: colorScheme.regularBaseColor,
          activedColor: colorScheme.deactivedColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.all(Radius.circular(8)),
          ),
          child: calculatorCells[i] == 'BACKSPACE'
              ? SVGIcon(
                  Ico.Backspace,
                  width: MEAS.itemOperationIconLength,
                  height: MEAS.itemOperationIconLength,
                )
              : Text(
                  calculatorCells[i],
                  style: TextStyles.greatTextStyle.copyWith(
                    color: colorScheme.primaryTextColor,
                  ),
                ),
          onPressed: () => onInput(calculatorCells[i]),
        ),
      ),
    );
  }
}
