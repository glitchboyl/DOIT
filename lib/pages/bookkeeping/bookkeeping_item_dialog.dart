import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'calculator.dart';
import 'package:doit/widgets/app_bar.dart';
import 'package:doit/widgets/text.dart';
import 'package:doit/widgets/text_button.dart';
import 'package:doit/widgets/svg_icon.dart';
import 'package:doit/widgets/input.dart';
import 'package:doit/widgets/bottom_drawer_select.dart';
import 'package:doit/widgets/bottom_drawer_item.dart';
import 'package:doit/widgets/icon.dart';
import 'package:doit/widgets/parts.dart';
import 'package:doit/models/bookkeeping_item.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/utils/show_bottom_drawer.dart';
import 'package:doit/utils/money_format.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class BookkeepingItemDialog extends StatefulWidget {
  const BookkeepingItemDialog({super.key, this.item});
  final BookkeepingItem? item;
  @override
  _BookkeepingItemDialogState createState() => _BookkeepingItemDialogState();
}

class _BookkeepingItemDialogState extends State<BookkeepingItemDialog> {
  bool _isActived = false;
  String _title = '';
  double _amount = 0;
  late DateTime _time;
  BookkeepingItemType _type = BookkeepingItemType.Expenses;

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _isActived = true;
      _amount = widget.item!.amount;
      _title = widget.item!.title;
      _time = widget.item!.time;
      _type = widget.item!.type;
    } else {
      final nowTime = DateTime.now();
      _time = nowTime;
    }
  }

  @override
  Widget build(BuildContext context) => Wrap(
        children: [
          AppBarBuilder(
            leadingWidth: 100.w,
            leading: GestureDetector(
              behavior: HitTestBehavior.translucent,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                runAlignment: WrapAlignment.center,
                children: [
                  SizedBox(width: 16.w),
                  SVGIcon(
                    'assets/images/date.svg',
                    width: MEAS.itemOperationIconLength,
                    height: MEAS.itemOperationIconLength,
                  ),
                  SizedBox(width: 6.w),
                  TextBuilder(
                    getTimeText(_time),
                    color: Styles.PrimaryColor,
                    fontSize: Styles.smallTextSize,
                    lineHeight: Styles.smallTextLineHeight,
                  ),
                ],
              ),
              onTap: () => showBottomDrawer(
                  context: context, builder: (context) => Container()
                  // BookkeepingItemCalendar(
                  //   startTime: _startTime,
                  //   endTime: _endTime,
                  //   onConfirmed: (startTime, endTime) => setState(() {
                  //     _startTime = startTime;
                  //     _endTime = endTime ?? startTime;
                  //   }),
                  // ),
                  ),
            ),
            trailings: [
              TextButtonBuilder(
                '确定',
                color: Styles.PrimaryColor,
                fontSize: Styles.textSize,
                lineHeight: Styles.textLineHeight,
                onPressed: () => {
                  // widget.onConfirmed(
                  //   _startTime,
                  //   _endTime,
                  // ),
                  Navigator.pop(context),
                },
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(
              top: 12.h,
              left: 16.w,
              right: 16.w,
              bottom: 28.h,
            ),
            child: Column(
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Styles.RegularBaseColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 12.w,
                      ),
                      GestureDetector(
                        child: Wrap(
                          runAlignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            SVGIcon(
                              'assets/images/${_type == BookkeepingItemType.Incomes ? 'incomes' : 'expenses'}.svg',
                              width: MEAS.bookkeepingItemTypeIconLength,
                              height: MEAS.bookkeepingItemTypeIconLength,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            TextBuilder(
                              _type == BookkeepingItemType.Incomes
                                  ? '收入'
                                  : '支出',
                              fontSize: Styles.smallTextSize,
                              lineHeight: Styles.smallTextLineHeight,
                            ),
                          ],
                        ),
                        onTap: () => setState(
                          () => _type = (_type == BookkeepingItemType.Incomes)
                              ? BookkeepingItemType.Expenses
                              : BookkeepingItemType.Incomes,
                        ),
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      SizedBox(
                        height: 12.h,
                        child: VerticalDivider(
                          width: 1.w,
                          thickness: 0.5.w,
                          color: Styles.DeactivedDeepColor,
                        ),
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      Expanded(
                        child: TextBuilder(
                          moneyFormat(_amount),
                          color: Styles.PrimaryTextColor,
                          fontSize: Styles.amountTextSize,
                          lineHeight: Styles.amountTextLineHeight,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: 120.w,
                        padding: EdgeInsets.only(
                          left: 8.w,
                          right: 12.w,
                        ),
                        child: Input(
                          initialValue: _title,
                          height: MEAS.titleInputHeight,
                          fontSize: Styles.smallTextSize,
                          lineHeight: Styles.smallTextLineHeight,
                          hintText: '要留下备注吗？',
                          maxLength: 50,
                          maxLines: 1,
                          border: bodyBorder,
                          onChanged: (value) => _title = value,
                        ),
                      ),
                    ],
                  ),
                ),
                Calculator(onInput: (input) {
                  switch (input) {
                    case 'BACKSPACE':
                      break;
                    case '.':
                      break;
                    default:
                      break;
                  }
                }),
              ],
            ),
          ),
        ],
      );
}
