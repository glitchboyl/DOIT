import 'package:flutter/material.dart';
import 'package:doit/widgets/app_bar.dart';
import 'package:doit/widgets/text.dart';
import 'package:doit/constants/styles.dart';

class NotesPageAppBar extends AppBarBuilder {
  const NotesPageAppBar({super.key});
  @override
  Widget build(BuildContext context) => AppBarBuilder(
        title: TextBuilder(
          '随记',
          color: Styles.PrimaryTextColor,
          fontWeight: FontWeight.bold,
          fontSize: Styles.largeTextSize,
          lineHeight: Styles.largeTextLineHeight,
        ),
      );
}
