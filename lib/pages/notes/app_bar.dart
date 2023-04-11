import 'package:flutter/material.dart';
import 'package:doit/widgets/app_bar.dart';
import 'package:doit/constants/styles.dart';

class NotesPageAppBar extends AppBarBuilder {
  const NotesPageAppBar({super.key});
  @override
  Widget build(BuildContext context) => AppBarBuilder(
        title: Text(
          '随记',
          style: TextStyles.greatTextStyle,
        ),
      );
}
