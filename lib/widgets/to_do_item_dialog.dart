import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_bar.dart';
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
import 'package:doit/utils/notification_service.dart';
import 'package:doit/utils/toast.dart';
// import 'package:doit/utils/local_calendar_service.dart';
import 'package:doit/models/to_do_item.dart';
import 'package:doit/providers/to_do_list.dart';
import 'package:doit/constants/icons.dart';
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
  NotificationType _notificationType = NotificationType.None;

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
      _notificationType = widget.item!.notificationType;
    } else {
      final _provider =
          Provider.of<ToDoListProvider>(this.context, listen: false);
      _startTime = _provider.pageIndex == 1
          ? _provider.focusedDate.add(
              const Duration(
                hours: 8,
              ),
            )
          : DateTime.now();
    }
  }

  @override
  Widget build(context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Wrap(
      children: [
        AppBarBuilder(
          height: MEAS.dialogAppBarHeight,
          title: Text(
            '${widget.item != null ? '编辑' : '添加'}日程',
            style: TextStyles.largeTextStyle.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          trailings: [
            SVGIconButton(
              _publishActived
                  ? isDarkMode
                      ? Ico.PublishDark
                      : Ico.Publish
                  : isDarkMode
                      ? Ico.PublishDisabledDark
                      : Ico.PublishDisabled,
              onPressed: () async {
                if (_publishActived) {
                  final _provider =
                      Provider.of<ToDoListProvider>(context, listen: false);
                  // await authorizeCalendar();
                  if (_notificationType != NotificationType.None) {
                    await authorizeNotification(context);
                  }
                  if (widget.item != null) {
                    bool isReduced = false;
                    if (!widget.item!.startTime.isSameDay(_startTime) ||
                        !widget.item!.endTime.isSameDay(_endTime)) {
                      isReduced = true;
                      _provider.reduce(widget.item!);
                    }
                    widget.item!.title = _title;
                    widget.item!.remarks = _remarks;
                    widget.item!.type = _type;
                    widget.item!.level = _level;
                    widget.item!.startTime = _startTime;
                    widget.item!.endTime = _endTime ?? _startTime;
                    widget.item!.repeatType = _repeatType;
                    widget.item!.notificationType = _notificationType;
                    if (isReduced) {
                      _provider.updateSchedule(widget.item!);
                      _provider.updateOverviewMap(widget.item!);
                    }
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
                        notificationType: _notificationType,
                      ),
                    );
                  }
                  Future.delayed(
                    const Duration(milliseconds: 100),
                    () => Toast.show(
                      context,
                      text: '${widget.item != null ? '编辑' : '创建'}成功',
                    ),
                  );
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
                color: colorScheme.primaryTextColor,
                style: TextStyles.regularTextStyle,
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
                padding: EdgeInsets.symmetric(vertical: 12),
                color: colorScheme.primaryTextColor,
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
                          Ico.Date,
                          width: MEAS.itemOperationIconLength,
                          height: MEAS.itemOperationIconLength,
                        ),
                        SizedBox(width: 6),
                        Text(
                          getToDoItemTimeText(
                              _startTime, _endTime ?? _startTime),
                          style: TextStyles.smallTextStyle.copyWith(
                            color: colorScheme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    onTap: () => showBottomDrawer(
                      context: context,
                      builder: (context) => ToDoItemCalendar(
                        startTime: _startTime,
                        endTime: _endTime,
                        notificationType: _notificationType,
                        onConfirmed: (startTime, endTime, notificationType) =>
                            setState(
                          () => {
                            _startTime = startTime,
                            _endTime = endTime ?? startTime,
                            _notificationType = notificationType,
                          },
                        ),
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
                      color: toDoItemLevelMap[_level]!.color(context),
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
                            color: toDoItemLevelMap[level]!.color(context),
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
                      color: toDoItemTypeMap[_type]!.color(context),
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
                            color: toDoItemTypeMap[type]!.color(context),
                            iconWidth: MEAS.toDoItemPropertyIconLength,
                            iconHeight: MEAS.toDoItemPropertyIconLength,
                          ),
                        ),
                        onSelected: (type, index) => {
                          if (_type != type)
                            setState(
                              () => _type = type,
                            )
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
}
