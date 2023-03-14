import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:provider/provider.dart';
import 'app_bar.dart';
import 'bookkeeping_item_dialog.dart';
import 'bookkeeping_statistics.dart';
import 'bookkeeping_list_title.dart';
import 'bookkeeping_item.dart';
import 'package:doit/pages/schedule/blank.dart';
import 'package:doit/models/bookkeeping_item.dart';
import 'package:doit/utils/show_bottom_drawer.dart';
import 'package:doit/utils/show_confirm_dialog.dart';
import 'package:doit/providers/bookkeeping.dart';
import 'package:doit/utils/time.dart';

class BookkeepingPage extends StatelessWidget {
  BookkeepingPage({super.key});

  final ItemScrollController _scrollController = ItemScrollController();
  final _positionsListener = ItemPositionsListener.create();
  int _freshWidgetIndex = 0;

  List<Widget> buildWidgets(
    BuildContext context,
    BookkeepingProvider provider,
  ) {
    final List<Widget> _widgets = [SizedBox(height: 20)];
    final bookkeepingDays = provider.bookkeepingListMap.keys.toList();
    int index = 0;
    bookkeepingDays
        .retainWhere((date) => date.isSameMonth(provider.focusedMonth));
    bookkeepingDays.sort((a, b) => b.compareTo(a));
    bookkeepingDays.forEach(
      (date) {
        final list = provider.bookkeepingListMap[date]!;
        _widgets.add(
          BookkeepingListTitle(
            date.isSameDay(nowTime) ? '今天' : getDateTime(date),
            key: ValueKey(date),
            incomes: provider.statisticsMap[date]![0],
            expenses: provider.statisticsMap[date]![1],
          ),
        );
        index++;
        for (int i = 0; i < list.length; i++) {
          if (provider.fresh == list[i]) {
            _freshWidgetIndex = index;
          }
          _widgets.add(
            BookkeepingItemWidget(
              list[i],
              onEdited: (context) => onEdited(context, list[i]),
              onDeleted: (context) => onDeleted(context, provider, list[i]),
            ),
          );
          index++;
        }
      },
    );
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
                        if (_widgets.length == 2) return ScheduleBlank();
                        if (provider.fresh != null) {
                          Future.delayed(
                            const Duration(milliseconds: 1),
                            () {
                              final _itemPositions = _positionsListener
                                  .itemPositions.value
                                  .toList();
                              if (_itemPositions.first.index >
                                      _freshWidgetIndex ||
                                  _itemPositions.last.index <
                                      _freshWidgetIndex) {
                                _scrollController.jumpTo(
                                  index: _freshWidgetIndex,
                                );
                              }
                              provider.refresh();
                            },
                          );
                        }

                        return ScrollablePositionedList.builder(
                          itemScrollController: _scrollController,
                          itemPositionsListener: _positionsListener,
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

  static final appBar = ({Key? key}) => BookkeepingPageAppBar(key: key);
}
