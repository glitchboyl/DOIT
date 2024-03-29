import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bookkeeping_item_calendar.dart';
import 'bookkeeping_item_category.dart';
import 'calculator.dart';
import 'package:doit/widgets/app_bar.dart';
import 'package:doit/widgets/text_button.dart';
import 'package:doit/widgets/svg_icon.dart';
import 'package:doit/widgets/input.dart';
import 'package:doit/widgets/gadgets.dart';
import 'package:doit/models/bookkeeping_item.dart';
import 'package:doit/providers/bookkeeping.dart';
import 'package:doit/providers/theme.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/utils/toast.dart';
import 'package:doit/utils/show_bottom_drawer.dart';
import 'package:doit/utils/money_format.dart';
import 'package:doit/constants/icons.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class BookkeepingItemDialog extends StatefulWidget {
  const BookkeepingItemDialog({super.key, this.item});
  final BookkeepingItem? item;
  @override
  _BookkeepingItemDialogState createState() => _BookkeepingItemDialogState();
}

class _BookkeepingItemDialogState extends State<BookkeepingItemDialog>
    with SingleTickerProviderStateMixin {
  bool _isActived = false;
  String _title = '';
  double _amount = 0;
  late DateTime _time;
  BookkeepingItemType _type = BookkeepingItemType.Expenses;
  late BookkeepingItemCategory _category;
  bool decimal = false;
  List<String> _input = [];
  late TabController _tabController;

  bool validate() => _amount != 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 1, length: 2, vsync: this);
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
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Wrap(
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
                  isDarkMode(context) ? Ico.DateDark : Ico.Date,
                  width: MEAS.itemOperationIconLength,
                  height: MEAS.itemOperationIconLength,
                ),
                SizedBox(width: 6),
                Text(
                  getTimeText(_time),
                  style: TextStyles.smallTextStyle.copyWith(
                    color: colorScheme.primaryColor,
                  ),
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
              style: TextStyles.regularTextStyle.copyWith(
                color: _isActived
                    ? colorScheme.primaryColor
                    : colorScheme.deactivedDeepColor,
                fontWeight: FontWeight.bold,
              ),
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
                            : bookkeepingItemCategoryMap[_category]!.text,
                        amount: _amount,
                        type: _type,
                        category: _category,
                        time: _time,
                      ),
                    );
                  }
                  Future.delayed(
                    const Duration(milliseconds: 100),
                    () => Toast.show(
                      context,
                      text: '${widget.item != null ? '编辑' : '新增'}成功',
                    ),
                  );
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
        Container(
          color: colorScheme.regularBaseColor,
          width: double.infinity,
          height: 280,
          child: Column(
            children: [
              Container(
                width: 96,
                height: 28,
                child: TabBar(
                  controller: _tabController,
                  labelStyle: TextStyle(
                    fontSize: TextStyles.SmallTextSize,
                  ),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                    color: colorScheme.tabActivedColor,
                  ),
                  labelPadding: EdgeInsets.zero,
                  labelColor: colorScheme.tabActivedTextColor,
                  unselectedLabelColor: colorScheme.tabTextColor,
                  tabs: [
                    Tab(
                      text: '收入',
                    ),
                    Tab(
                      text: '支出',
                    ),
                  ],
                  onTap: (index) {
                    if (index != _type.index) {
                      setState(
                        () => {
                          _type = BookkeepingItemType.values[index],
                          _category = BookkeepingItemCategoryList[_type]![0],
                        },
                      );
                    }
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
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
                        icon:
                            bookkeepingItemCategoryMap[category]!.icon(context),
                        text: bookkeepingItemCategoryMap[category]!.text,
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
                  color: colorScheme.regularBaseColor,
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
                        hintText: '要留下备注吗？',
                        color: colorScheme.primaryTextColor,
                        maxLength: 50,
                        maxLines: 1,
                        border: bodyBorder,
                        onChanged: (value) => _title = value,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        moneyFormat(_amount),
                        style: TextStyles.amountTextStyle.copyWith(
                          color: colorScheme.primaryTextColor,
                        ),
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
}
