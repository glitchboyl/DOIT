import 'package:doit/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doit/widgets/app_bar.dart';
import 'package:doit/widgets/svg_icon_button.dart';
import 'package:doit/providers/note.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class BookkeepingChartPage extends StatefulWidget {
  const BookkeepingChartPage({super.key});
  @override
  _BookkeepingChartPageState createState() => _BookkeepingChartPageState();
}

class _BookkeepingChartPageState extends State<BookkeepingChartPage> {
  NoteProvider getProvider(BuildContext context, {bool listen = true}) =>
      Provider.of<NoteProvider>(
        context,
        listen: listen,
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBarBuilder(
          leading: SVGIconButton(
            'assets/images/back.svg',
            onPressed: () => Navigator.pop(context),
          ),
          title: TextBuilder(
            '图表',
            color: Styles.RegularBaseColor,
            fontWeight: FontWeight.bold,
            fontSize: Styles.greatTextSize,
            lineHeight: Styles.greatTextLineHeight,
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(
            top: 12,
            left: 16,
            right: 16,
            bottom: 18,
          ),
          child: Column(),
        ),
      );
}
