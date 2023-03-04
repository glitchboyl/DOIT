import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_bar.dart';
import 'svg_icon.dart';
import 'svg_icon_button.dart';
import 'add_to_do_item_dialog_input.dart';
import 'add_to_do_item_calendar.dart';
import 'bottom_drawer_select.dart';
import 'bottom_drawer_select_item.dart';
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

class AddToDoItemDialog extends StatefulWidget {
  const AddToDoItemDialog({super.key});
  @override
  _AddToDoItemDialogState createState() => _AddToDoItemDialogState();
}

class _AddToDoItemDialogState extends State<AddToDoItemDialog> {
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
    final nowTime = DateTime.now();
    _startTime = nowTime;
    _endTime = nowTime;
  }

  @override
  Widget build(context) => Wrap(
        children: <Widget>[
          AppBarBuilder(
            title: Text(
              '添加日程',
              style: TextStyle(
                color: Styles.PrimaryTextColor,
                fontWeight: FontWeight.bold,
                fontSize: Styles.largeTextSize,
                height: Styles.largeTextLineHeight / Styles.largeTextSize,
              ),
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
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Column(
              children: [
                AddToDoItemDialogInput(
                  height: MEAS.addToDoItemDialogTitleInputHeight,
                  hintText: '有好计划吗，快记录下来吧…',
                  border: titleBorder,
                  onChanged: (value) => setState(() {
                    _title = value;
                    _sendActived = validate();
                  }),
                ),
                AddToDoItemDialogInput(
                  height: MEAS.addToDoItemDialogRemarksInputHeight,
                  hintText: '描述信息',
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
                          Text(
                            getToDoItemTime(_startTime, _endTime),
                            // 'qweqwe',
                            style: TextStyle(
                              color: Styles.PrimaryColor,
                              fontSize: Styles.smallTextSize,
                              height: Styles.smallTextLineHeight /
                                  Styles.smallTextSize,
                            ),
                          ),
                        ],
                      ),
                      onTap: () => showBottomDrawer(
                        context: context,
                        builder: (context) => AddToDoItemCalendar(),
                      ),
                    ),
                    GestureDetector(
                      child: IconBuilder(
                        width: MEAS.addToDoItemPropertyWidth,
                        height: MEAS.addToDoItemPropertyWidth,
                        margin: EdgeInsets.only(
                          left: 20.w,
                        ),
                        borderRadius: BorderRadius.circular(50.r),
                        color: toDoItemLevelMap[_level]!.color,
                        icon: toDoItemLevelMap[_level]!.icon,
                        iconWidth: MEAS.addToDoItemPropertyIconWidth,
                        iconHeight: MEAS.addToDoItemPropertyIconHeight,
                      ),
                      onTap: () => showBottomDrawer(
                        context: context,
                        builder: (context) => BottomDrawerSelect<ToDoItemLevel>(
                          title: '选择等级',
                          selectList: toDoItemLevelMap.keys.toList(),
                          itemBuilder: (level, index) => BottomDrawerSelectItem(
                            key: ValueKey(level),
                            title: toDoItemLevelMap[level]!.text,
                            icon: IconBuilder(
                              width: MEAS.addToDoItemPropertyWidth,
                              height: MEAS.addToDoItemPropertyWidth,
                              borderRadius: BorderRadius.circular(50.r),
                              color: toDoItemLevelMap[level]!.color,
                              icon: toDoItemLevelMap[level]!.icon,
                              iconWidth: MEAS.addToDoItemPropertyIconWidth,
                              iconHeight: MEAS.addToDoItemPropertyIconHeight,
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
                        width: MEAS.addToDoItemPropertyWidth,
                        height: MEAS.addToDoItemPropertyWidth,
                        margin: EdgeInsets.only(
                          left: 20.w,
                        ),
                        borderRadius: BorderRadius.circular(6.r),
                        color: toDoItemTypeMap[_type]!.color,
                        icon: toDoItemTypeMap[_type]!.icon,
                        iconWidth: MEAS.addToDoItemPropertyIconWidth,
                        iconHeight: MEAS.addToDoItemPropertyIconHeight,
                      ),
                      onTap: () => showBottomDrawer(
                        context: context,
                        builder: (context) => BottomDrawerSelect<ToDoItemType>(
                          title: '选择标签',
                          selectList: toDoItemTypeMap.keys.toList(),
                          itemBuilder: (type, index) => BottomDrawerSelectItem(
                            key: ValueKey(type),
                            title: toDoItemTypeMap[type]!.text,
                            icon: IconBuilder(
                              width: MEAS.addToDoItemPropertyWidth,
                              height: MEAS.addToDoItemPropertyWidth,
                              borderRadius: BorderRadius.circular(6.r),
                              color: toDoItemTypeMap[type]!.color,
                              icon: toDoItemTypeMap[type]!.icon,
                              iconWidth: MEAS.addToDoItemPropertyIconWidth,
                              iconHeight: MEAS.addToDoItemPropertyIconHeight,
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
