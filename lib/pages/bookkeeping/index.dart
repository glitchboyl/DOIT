import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'app_bar.dart';
import 'bookkeeping_item_dialog.dart';
import 'bookkeeping_statistics.dart';
import 'bookkeeping_list_title.dart';
import 'bookkeeping_item.dart';
import 'package:doit/models/bookkeeping_item.dart';
import 'package:doit/utils/show_bottom_drawer.dart';
import 'package:doit/utils/show_confirm_dialog.dart';
import 'package:doit/providers/bookkeeping.dart';
import 'package:doit/utils/time.dart';

class BookkeepingPage extends StatefulWidget {
  const BookkeepingPage({super.key});
  @override
  _BookkeepingPageState createState() => _BookkeepingPageState();

  static final appBar = ({Key? key}) => BookkeepingPageAppBar(key: key);
}

class _BookkeepingPageState extends State<BookkeepingPage> {
  List<Widget> buildWidgets(
      BuildContext context, BookkeepingProvider provider) {
    final List<Widget> _widgets = [SizedBox(height: 20)];
    final bookkeepingDays = provider.bookkeepingListMap.keys.toList();
    bookkeepingDays
        .retainWhere((date) => date.isSameMonth(provider.focusedMonth));
    bookkeepingDays.sort((a, b) => b.compareTo(a));
    bookkeepingDays.forEach((date) {
      final list = provider.bookkeepingListMap[date]!;
      _widgets.add(
        BookkeepingListTitle(
          date.isSameDay(nowTime) ? '今天' : getDateTime(date),
          key: ValueKey(date),
          incomes: provider.statisticsMap[date]![0],
          expenses: provider.statisticsMap[date]![1],
        ),
      );
      for (int i = 0; i < list.length; i++) {
        _widgets.add(
          BookkeepingItemWidget(
            list[i],
            onEdited: (context) => onEdited(context, list[i]),
            onDeleted: (context) => onDeleted(context, provider, list[i]),
          ),
        );
      }
    });
    _widgets.add(SizedBox(height: 12));
    return _widgets;
  }

  void onEdited(BuildContext context, BookkeepingItem item) => showBottomDrawer(
        context: context,
        builder: (context) => BookkeepingItemDialog(
          item: item,
        ),
      );

  void onDeleted(BuildContext context, BookkeepingProvider provider,
          BookkeepingItem item) =>
      showConfirmDialog(
        '确定要删除"${item.title}"吗？',
        context: context,
        danger: true,
        onConfirm: (context) => {
          provider.delete(item),
          Navigator.pop(context),
        },
      );

  @override
  Widget build(BuildContext context) => Container(
        // margin: EdgeInsets.only(top: 0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bookkeeping_bg.png'),
            alignment: Alignment.center,
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(top: 116, left: 16, right: 16),
                child: Container(
                  child: SlidableAutoCloseBehavior(
                    child: Consumer<BookkeepingProvider>(
                      builder: (context, provider, _) {
                        final _widgets = buildWidgets(context, provider);
                        return ListView.builder(
                          itemBuilder: (context, index) => _widgets[index],
                          itemCount: _widgets.length,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            BookkeepingStatistics(),
          ],
        ),
      );
}
