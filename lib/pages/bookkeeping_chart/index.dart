import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doit/widgets/app_bar.dart';
import 'package:doit/widgets/svg_icon_button.dart';
import 'package:doit/widgets/text.dart';
import 'line_chart.dart';
import 'package:doit/providers/note.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class BookkeepingChartPage extends StatefulWidget {
  const BookkeepingChartPage({super.key});
  @override
  _BookkeepingChartPageState createState() => _BookkeepingChartPageState();
}

class _BookkeepingChartPageState extends State<BookkeepingChartPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

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
            color: Styles.PrimaryTextColor,
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
          child: Column(
            children: [
              Container(
                height: 44,
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Styles.RegularBaseColor,
                  borderRadius: BorderRadius.circular(
                    12,
                  ),
                ),
                child: TabBar(
                  controller: _tabController,
                  labelStyle: TextStyle(
                    fontSize: Styles.smallTextSize,
                  ),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                    color: Styles.PrimaryColor,
                  ),
                  labelColor: Styles.RegularBaseColor,
                  unselectedLabelColor: Styles.PrimaryTextColor,
                  tabs: [
                    Tab(
                      text: '一周',
                    ),
                    Tab(
                      text: '整月',
                    ),
                    Tab(
                      text: '整年',
                    ),
                    Tab(
                      text: '总览',
                    ),
                  ],
                  onTap: (index) {
                    print(index);
                  }
                ),
              ),
              BookkeepingLineChart(),
            ],
          ),
        ),
      );
}
