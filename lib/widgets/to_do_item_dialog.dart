import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_bar.dart';
import 'text.dart';
import 'svg_icon.dart';
import 'svg_icon_button.dart';
import 'input.dart';
import 'to_do_item_calendar.dart';
import 'bottom_drawer_select.dart';
import 'bottom_drawer_item.dart';
import 'icon.dart';
import 'parts.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/utils/show_bottom_drawer.dart';
import 'package:doit/models/to_do_item.dart';
import 'package:doit/providers/to_do_list.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class ToDoItemDialog extends StatefulWidget {
  const ToDoItemDialog({super.key, this.item});
  final ToDoItem? item;
  @override
  _ToDoItemDialogState createState() => _ToDoItemDialogState();
}

class _ToDoItemDialogState extends State<ToDoItemDialog> {
  bool _publishActived = false;
  String _title = '';
  String _remarks = '';
  late DateTime _startTime;
  DateTime? _endTime;
  ToDoItemLevel _level = ToDoItemLevel.IV;
  ToDoItemType _type = ToDoItemType.Life;
  RepeatType _repeatType = RepeatType.Never;

  bool validate() => _title.trim() != '';

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _publishActived = true;
      _title = widget.item!.title;
      _remarks = widget.item!.remarks;
      _startTime = widget.item!.startTime;
      _endTime = widget.item!.endTime;
      _level = widget.item!.level;
      _type = widget.item!.type;
    } else {
      final _provider =
          Provider.of<ToDoListProvider>(this.context, listen: false);
      _startTime =
          _provider.pageIndex == 1 ? _provider.focusedDate : DateTime.now();
    }
  }

  @override
  Widget build(context) => Wrap(
        children: [
          AppBarBuilder(
            title: TextBuilder(
              '${widget.item != null ? '编辑' : '添加'}日程',
              color: Styles.PrimaryTextColor,
              fontSize: Styles.largeTextSize,
              lineHeight: Styles.largeTextLineHeight,
              fontWeight: FontWeight.bold,
            ),
            trailings: [
              SVGIconButton(
                'assets/images/publish${_publishActived ? '' : '_disabled'}.svg',
                onPressed: () {
                  if (_publishActived) {
                    final _provider =
                        Provider.of<ToDoListProvider>(context, listen: false);
                    if (widget.item != null) {
                      widget.item!.title = _title;
                      widget.item!.remarks = _remarks;
                      widget.item!.type = _type;
                      widget.item!.level = _level;
                      widget.item!.startTime = _startTime;
                      widget.item!.endTime = _endTime ?? _startTime;
                      widget.item!.repeatType = _repeatType;
                      _provider.update(widget.item!);
                    } else {
                      _provider.insert(
                        ToDoItem(
                          id: UniqueKey().hashCode,
                          title: _title,
                          remarks: _remarks,
                          type: _type,
                          level: _level,
                          startTime: _startTime,
                          endTime: _endTime ?? _startTime,
                          repeatType: _repeatType,
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
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 12,
              bottom: 18,
            ),
            child: Column(
              children: [
                Input(
                  initialValue: _title,
                  height: MEAS.titleInputHeight,
                  fontSize: Styles.textSize,
                  lineHeight: Styles.textLineHeight,
                  hintText: '有新日程吗，快记录下来吧…',
                  maxLength: 50,
                  maxLines: 1,
                  autofocus: true,
                  border: titleBorder,
                  onChanged: (value) => setState(() {
                    _title = value;
                    _publishActived = validate();
                  }),
                ),
                Input(
                  initialValue: _remarks,
                  height: MEAS.toDoItemDialogRemarksInputHeight,
                  color: Styles.PrimaryTextColor,
                  hintText: '有额外要记下的事情吗？',
                  maxLength: 150,
                  maxLines: 3,
                  border: bodyBorder,
                  onChanged: (value) => _remarks = value,
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      child: Row(
                        children: [
                          SVGIcon(
                            'assets/images/date.svg',
                            width: MEAS.itemOperationIconLength,
                            height: MEAS.itemOperationIconLength,
                          ),
                          SizedBox(width: 6),
                          TextBuilder(
                            getToDoItemTimeText(
                                _startTime, _endTime ?? _startTime),
                            color: Styles.PrimaryColor,
                            fontSize: Styles.smallTextSize,
                            lineHeight: Styles.smallTextLineHeight,
                          ),
                        ],
                      ),
                      onTap: () => showBottomDrawer(
                        context: context,
                        builder: (context) => ToDoItemCalendar(
                          startTime: _startTime,
                          endTime: _endTime,
                          onConfirmed: (startTime, endTime) => setState(() {
                            _startTime = startTime;
                            _endTime = endTime ?? startTime;
                          }),
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: IconBuilder(
                        toDoItemLevelMap[_level]!.icon,
                        width: MEAS.toDoItemPropertyLength,
                        height: MEAS.toDoItemPropertyLength,
                        margin: EdgeInsets.only(
                          left: 20,
                        ),
                        borderRadius: BorderRadius.circular(50),
                        color: toDoItemLevelMap[_level]!.color,
                        iconWidth: MEAS.toDoItemPropertyIconLength,
                        iconHeight: MEAS.toDoItemPropertyIconLength,
                      ),
                      onTap: () => showBottomDrawer(
                        context: context,
                        builder: (context) => BottomDrawerSelect<ToDoItemLevel>(
                          title: '选择等级',
                          selectList: toDoItemLevelMap.keys.toList(),
                          itemBuilder: (level, index) => BottomDrawerItem(
                            key: ValueKey(level),
                            title: toDoItemLevelMap[level]!.text,
                            icon: IconBuilder(
                              toDoItemLevelMap[level]!.icon,
                              width: MEAS.toDoItemPropertyLength,
                              height: MEAS.toDoItemPropertyLength,
                              borderRadius: BorderRadius.circular(50),
                              color: toDoItemLevelMap[level]!.color,
                              iconWidth: MEAS.toDoItemPropertyIconLength,
                              iconHeight: MEAS.toDoItemPropertyIconLength,
                            ),
                          ),
                          onSelected: (level, index) => {
                            if (_level != level)
                              setState(() {
                                _level = level;
                              })
                          },
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: IconBuilder(
                        toDoItemTypeMap[_type]!.icon,
                        width: MEAS.toDoItemPropertyLength,
                        height: MEAS.toDoItemPropertyLength,
                        margin: EdgeInsets.only(
                          left: 20,
                        ),
                        borderRadius: BorderRadius.circular(6),
                        color: toDoItemTypeMap[_type]!.color,
                        iconWidth: MEAS.toDoItemPropertyIconLength,
                        iconHeight: MEAS.toDoItemPropertyIconLength,
                      ),
                      onTap: () => showBottomDrawer(
                        context: context,
                        builder: (context) => BottomDrawerSelect<ToDoItemType>(
                          title: '选择标签',
                          selectList: toDoItemTypeMap.keys.toList(),
                          itemBuilder: (type, index) => BottomDrawerItem(
                            key: ValueKey(type),
                            title: toDoItemTypeMap[type]!.text,
                            icon: IconBuilder(
                              toDoItemTypeMap[type]!.icon,
                              width: MEAS.toDoItemPropertyLength,
                              height: MEAS.toDoItemPropertyLength,
                              borderRadius: BorderRadius.circular(6),
                              color: toDoItemTypeMap[type]!.color,
                              iconWidth: MEAS.toDoItemPropertyIconLength,
                              iconHeight: MEAS.toDoItemPropertyIconLength,
                            ),
                          ),
                          onSelected: (type, index) => {
                            if (_type != type)
                              setState(() {
                                _type = type;
                              })
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      );
}
