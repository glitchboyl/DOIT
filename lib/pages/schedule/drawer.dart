import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'expansion_tile.dart';
import 'drawer_item.dart';
import 'package:doit/models/to_do_item.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';
import 'package:doit/constants/keys.dart';

class SchedulePageDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Drawer(
        width: MEAS.drawerWidth,
        elevation: 0,
        shadowColor: Colors.transparent,
        child: Column(
          children: [
            SizedBox(
              height: 56.h,
            ),
            ExpansionTileBuilder(
              title: SchedulePageDrawerItem(
                icon: 'assets/images/schedule_sort.svg',
                title: '我的日程',
                // onTap: () => {
                //   print(ExpansionTileBuilder.of(context)),
                //   // ExpansionTileBuilder.of(context)._handleTap(),
                // },
              ),
              children: [
                SchedulePageDrawerItem(
                  key: Keys.DrawerItemAllSchedule,
                  icon: 'assets/images/all.svg',
                  title: '全部日程',
                  color: Styles.PrimaryTextColor,
                  onTap: () => {},
                ),
                ...toDoItemTypeMap.entries
                    .map<Widget>(
                      (type) => SchedulePageDrawerItem(
                        key: ValueKey(type.key),
                        icon: type.value.icon,
                        title: type.value.text,
                        color: type.value.color,
                        onTap: () => {},
                      ),
                    )
                    .toList()
              ],
            ),
            SchedulePageDrawerItem(
              icon: 'assets/images/statistics.svg',
              title: '日程统计',
              onTap: () => {},
            ),
            SchedulePageDrawerItem(
              icon: 'assets/images/anniversary.svg',
              title: '纪念日',
              onTap: () => {},
            ),
            SchedulePageDrawerItem(
              icon: 'assets/images/bin.svg',
              title: '废纸篓',
              onTap: () => {},
            ),
          ],
        ),
      );
}
