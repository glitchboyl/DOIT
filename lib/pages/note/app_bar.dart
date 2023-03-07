import 'package:flutter/material.dart';
import 'package:doit/widgets/app_bar.dart';
import 'package:doit/widgets/svg_icon_button.dart';

class NotesPageAppBar extends AppBarBuilder {
  const NotesPageAppBar({super.key});
  @override
  Widget build(BuildContext context) => AppBarBuilder(
        leading: SVGIconButton(
          'assets/images/back.svg',
          onPressed: () => Navigator.of(context).pop(),
        ),
        trailings: [
          SVGIconButton(
            'assets/images/edit.svg',
            onPressed: () => {},
          ),
          SVGIconButton(
            'assets/images/trash.svg',
            onPressed: () => {},
          ),
        ],
      );
}
