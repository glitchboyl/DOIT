import 'package:flutter/material.dart';
import 'package:doit/widgets/app_bar.dart';
import 'package:doit/widgets/svg_icon_button.dart';
import 'package:doit/constants/icons.dart';
import 'package:doit/constants/styles.dart';

class BookkeepingPageAppBar extends AppBarBuilder {
  const BookkeepingPageAppBar({super.key});
  @override
  Widget build(BuildContext context) => AppBarBuilder(
        title: Text(
          '记账',
          style: TextStyles.greatTextStyle.copyWith(
            color: Theme.of(context).colorScheme.regularBaseColor,
          ),
        ),
        backgroundColor: Colors.transparent,
        trailings: [
          SVGIconButton(
            Ico.BookkeepingChart,
            onPressed: () => Navigator.pushNamed(context, '/bookkeeping_chart'),
          ),
        ],
      );
}
