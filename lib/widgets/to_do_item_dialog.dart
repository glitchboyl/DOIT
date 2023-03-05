import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_bar.dart';
import 'text.dart';
import 'svg_icon.dart';
import 'svg_icon_button.dart';
import 'to_do_item_dialog_input.dart';
import 'to_do_item_calendar.dart';
import 'bottom_drawer_select.dart';
import 'bottom_drawer_item.dart';
import 'icon.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/utils/show_bottom_drawer.dart';
import 'package:doit/models/to_do_item.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

UnderlineInputBorder titleBorder = UnderlineInputBorder(
  borderSide: BorderSide(color: Styles.BackgroundColor, width: 2.h),
);
UnderlineInputBorder remarksBorder = UnderlineInputBorder(
  borderSide: BorderSide(
    color: Colors.transparent,
  ),
);

class ToDoItemDialog extends StatefulWidget {
  const ToDoItemDialog({super.key, this.item});
  final ToDoItem? item;
  @override
  _ToDoItemDialogState createState() => _ToDoItemDialogState();
}

class _ToDoItemDialogState extends State<ToDoItemDialog> {
  bool _sendActived = false;
  String _title = '';
  String _remarks = '';
  late DateTime _startTime;
  late DateTime _endTime;
  ToDoItemLevel _level = ToDoItemLevel.IV;
  ToDoItemType _type = ToDoItemType.Life;

  bool validate() => _title.trim() != '';

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _sendActived = true;
      _title = widget.item!.title;
      _remarks = widget.item!.remarks;
      _startTime = widget.item!.startTime;
      _endTime = widget.item!.endTime;
      _level = widget.item!.level;
      _type = widget.item!.type;
    } else {
      final nowTime = DateTime.now();
      _startTime = nowTime;
      _endTime = nowTime;
    }
  }

  @override
  Widget build(context) => Wrap(
        children: <Widget>[
          AppBarBuilder(
            title: TextBuilder(
              '${widget.item != null ? '编辑' : '添加'}日程',
              color: Styles.PrimaryTextColor,
              fontSize: Styles.largeTextSize,
              lineHeight: Styles.largeTextLineHeight,
              fontWeight: FontWeight.bold,
            ),
            trailing: SVGIconButton(
              icon: 'assets/images/send${_sendActived ? '' : '_disabled'}.svg',
              onPressed: () => {
                if (_sendActived)
                  {
                    print(_title),
                    print(_remarks),
                  }
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 12.h,
              bottom: 18.h,
            ),
            child: Column(
              children: [
                ToDoItemDialogInput(
                  initialValue: _title,
                  height: MEAS.toDoItemDialogTitleInputHeight,
                  hintText: '有新日程吗，快记录下来吧…',
                  maxLength: 50,
                  autofocus: true,
                  border: titleBorder,
                  onChanged: (value) => setState(() {
                    _title = value;
                    _sendActived = validate();
                  }),
                ),
                ToDoItemDialogInput(
                  initialValue: _remarks,
                  height: MEAS.toDoItemDialogRemarksInputHeight,
                  hintText: '有额外要记下的事情吗？',
                  maxLength: 150,
                  border: remarksBorder,
                  onChanged: (value) => _remarks = value,
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      child: Row(
                        children: [
                          SVGIcon(
                            icon: 'assets/images/date.svg',
                            width: MEAS.simpleToDoItemOperationIconWidth,
                            height: MEAS.simpleToDoItemOperationIconHeight,
                          ),
                          SizedBox(width: 6.w),
                          TextBuilder(
                            getToDoItemTime(_startTime, _endTime),
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
                        width: MEAS.toDoItemPropertyWidth,
                        height: MEAS.toDoItemPropertyWidth,
                        margin: EdgeInsets.only(
                          left: 20.w,
                        ),
                        borderRadius: BorderRadius.circular(50.r),
                        color: toDoItemLevelMap[_level]!.color,
                        icon: toDoItemLevelMap[_level]!.icon,
                        iconWidth: MEAS.toDoItemPropertyIconWidth,
                        iconHeight: MEAS.toDoItemPropertyIconHeight,
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
                              width: MEAS.toDoItemPropertyWidth,
                              height: MEAS.toDoItemPropertyWidth,
                              borderRadius: BorderRadius.circular(50.r),
                              color: toDoItemLevelMap[level]!.color,
                              icon: toDoItemLevelMap[level]!.icon,
                              iconWidth: MEAS.toDoItemPropertyIconWidth,
                              iconHeight: MEAS.toDoItemPropertyIconHeight,
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
                        width: MEAS.toDoItemPropertyWidth,
                        height: MEAS.toDoItemPropertyWidth,
                        margin: EdgeInsets.only(
                          left: 20.w,
                        ),
                        borderRadius: BorderRadius.circular(6.r),
                        color: toDoItemTypeMap[_type]!.color,
                        icon: toDoItemTypeMap[_type]!.icon,
                        iconWidth: MEAS.toDoItemPropertyIconWidth,
                        iconHeight: MEAS.toDoItemPropertyIconHeight,
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
                              width: MEAS.toDoItemPropertyWidth,
                              height: MEAS.toDoItemPropertyWidth,
                              borderRadius: BorderRadius.circular(6.r),
                              color: toDoItemTypeMap[type]!.color,
                              icon: toDoItemTypeMap[type]!.icon,
                              iconWidth: MEAS.toDoItemPropertyIconWidth,
                              iconHeight: MEAS.toDoItemPropertyIconHeight,
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
