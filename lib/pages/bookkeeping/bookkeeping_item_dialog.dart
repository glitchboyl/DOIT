import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'bookkeeping_item_calendar.dart';
import 'bookkeeping_item_category.dart';
import 'calculator.dart';
import 'package:doit/widgets/app_bar.dart';
import 'package:doit/widgets/text.dart';
import 'package:doit/widgets/text_button.dart';
import 'package:doit/widgets/svg_icon.dart';
import 'package:doit/widgets/input.dart';
import 'package:doit/widgets/parts.dart';
import 'package:doit/widgets/switch_button.dart';
import 'package:doit/models/bookkeeping_item.dart';
import 'package:doit/providers/bookkeeping.dart';
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
  late BookkeepingItemCategory _category;
  bool decimal = false;
  List<String> _input = [];

  bool validate() => _amount != 0;

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _isActived = true;
      _amount = widget.item!.amount;
      _title = widget.item!.title;
      _time = widget.item!.time;
      _type = widget.item!.type;
      _category = widget.item!.category;
      _input = _amount.toString().split('');
      if (_input.contains('.')) {
        if (_input.indexOf('.') == _input.length - 2 && _input.last == '0') {
          _input.removeRange(_input.length - 2, _input.length);
        } else {
          decimal = true;
        }
      }
    } else {
      _time = DateTime.now();
      _category = BookkeepingItemCategoryList[_type]![0];
    }
  }

  @override
  Widget build(BuildContext context) => Wrap(
        children: [
          AppBarBuilder(
            height: MEAS.dialogAppBarHeight,
            leadingWidth: 160,
            leading: GestureDetector(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                runAlignment: WrapAlignment.center,
                children: [
                  SizedBox(width: 16),
                  SVGIcon(
                    'assets/images/date.svg',
                    width: MEAS.itemOperationIconLength,
                    height: MEAS.itemOperationIconLength,
                  ),
                  SizedBox(width: 6),
                  TextBuilder(
                    getTimeText(_time),
                    color: Styles.PrimaryColor,
                    fontSize: Styles.smallTextSize,
                    lineHeight: Styles.smallTextLineHeight,
                  ),
                ],
              ),
              onTap: () => showBottomDrawer(
                context: context,
                builder: (context) => BookkeepingItemCalendar(
                  time: _time,
                  onConfirmed: (time) => setState(
                    () => _time = time,
                  ),
                ),
              ),
            ),
            trailings: [
              TextButtonBuilder(
                '确定',
                color: _isActived
                    ? Styles.PrimaryColor
                    : Styles.DeactivedDeepColor,
                fontSize: Styles.textSize,
                lineHeight: Styles.textLineHeight,
                fontWeight: FontWeight.bold,
                onPressed: () {
                  if (_isActived) {
                    final _provider = Provider.of<BookkeepingProvider>(
                      context,
                      listen: false,
                    );
                    if (widget.item != null) {
                      _provider.reduce(widget.item!);
                      widget.item!.title = _title;
                      widget.item!.amount = _amount;
                      widget.item!.type = _type;
                      widget.item!.category = _category;
                      widget.item!.time = _time;
                      _provider.update(widget.item!);
                    } else {
                      _provider.insert(
                        BookkeepingItem(
                          id: UniqueKey().hashCode,
                          title: _title.trim() != ''
                              ? _title
                              : BookkeepingItemCategoryMap[_category]!.text,
                          amount: _amount,
                          type: _type,
                          category: _category,
                          time: _time,
                        ),
                      );
                    }
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
          Container(
            color: Styles.RegularBaseColor,
            width: double.infinity,
            height: 292,
            child: Column(
              children: [
                Wrap(
                  children: [
                    SwitchButton(
                      '收入',
                      isActived: _type == BookkeepingItemType.Incomes,
                      onPressed: () {
                        if (_type != BookkeepingItemType.Incomes)
                          setState(
                            () => {
                              _type = BookkeepingItemType.Incomes,
                              _category =
                                  BookkeepingItemCategoryList[_type]![0],
                            },
                          );
                      },
                    ),
                    SizedBox(width: 12),
                    SwitchButton(
                      '支出',
                      isActived: _type == BookkeepingItemType.Expenses,
                      onPressed: () {
                        if (_type != BookkeepingItemType.Expenses)
                          setState(
                            () => {
                              _type = BookkeepingItemType.Expenses,
                              _category =
                                  BookkeepingItemCategoryList[_type]![0],
                            },
                          );
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 8,
                      left: 16,
                      right: 16,
                      bottom: 12,
                    ),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 26,
                        mainAxisSpacing: 10,
                        childAspectRatio:
                            (MediaQuery.of(context).size.width - 136) / 5 / 68,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: BookkeepingItemCategoryList[_type]!.length,
                      itemBuilder: (context, i) {
                        final category = BookkeepingItemCategoryList[_type]![i];
                        return BookkeepingItemCategoryWidget(
                          key: ValueKey('$_type:$category'),
                          isActived: category == _category,
                          icon: BookkeepingItemCategoryMap[category]!.icon,
                          text: BookkeepingItemCategoryMap[category]!.text,
                          onTap: () {
                            if (category != _category) {
                              setState(
                                () => _category = category,
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 12,
              left: 16,
              right: 16,
            ),
            child: Column(
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Styles.RegularBaseColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 160,
                        padding: EdgeInsets.only(
                          left: 12,
                          right: 12,
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
                      Expanded(
                        child: TextBuilder(
                          moneyFormat(_amount),
                          color: Styles.PrimaryTextColor,
                          fontSize: Styles.amountTextSize,
                          lineHeight: Styles.amountTextLineHeight,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.right,
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                    ],
                  ),
                ),
                Calculator(
                  onInput: (input) {
                    switch (input) {
                      case 'BACKSPACE':
                        if (_input.length > 0) {
                          _input.removeLast();
                          if (_input.length > 0 && _input.last == '.') {
                            _input.removeLast();
                            decimal = false;
                          }
                        }
                        break;
                      case '.':
                        if (!decimal) {
                          decimal = true;
                          _input.add(input);
                        }
                        break;
                      default:
                        if ((!decimal && _input.length < 9) ||
                            (decimal &&
                                _input.indexOf('.') != _input.length - 3)) {
                          if (_input.length == 1 && _input[0] == '0')
                            _input[0] = input;
                          else
                            _input.add(input);
                        }
                        break;
                    }
                    final result = double.tryParse(_input.join('')) ?? 0;
                    if (_amount != result) {
                      setState(
                        () => {
                          _amount = result,
                          _isActived = validate(),
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      );
}
