import 'package:doit/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'expansion_tile.dart';
import 'drawer_item.dart';
import 'package:doit/providers/theme.dart';
// import 'package:doit/models/to_do_item.dart';
// import 'package:doit/constants/styles.dart';
import 'package:doit/constants/icons.dart';
import 'package:doit/constants/meas.dart';
// import 'package:doit/constants/keys.dart';

class SchedulePageDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Drawer(
      width: MEAS.drawerWidth,
      elevation: 0,
      shadowColor: Colors.transparent,
      backgroundColor: Theme.of(context).colorScheme.regularBaseColor,
      child: Column(
        children: [
          SizedBox(
            height: 56,
          ),
          // ExpansionTileBuilder(
          //   title: SchedulePageDrawerItem(
          //     icon: Ico.ScheduleSort,
          //     title: '我的日程',
          //     // onTap: () => {
          //     //   print(ExpansionTileBuilder.of(context)),
          //     //   // ExpansionTileBuilder.of(context)._handleTap(),
          //     // },
          //   ),
          //   children: [
          //     SchedulePageDrawerItem(
          //       key: Keys.DrawerItemAllSchedule,
          //       icon: Ico.AllSchedule,
          //       title: '全部日程',
          //       color: Styles.PrimaryTextColor,
          //       onTap: () => {},
          //     ),
          //     ...toDoItemTypeMap.entries
          //         .map<Widget>(
          //           (type) => SchedulePageDrawerItem(
          //             key: ValueKey(type.key),
          //             icon: type.value.icon,
          //             title: type.value.text,
          //             color: type.value.color,
          //             onTap: () => {},
          //           ),
          //         )
          //         .toList()
          //   ],
          // ),
          SchedulePageDrawerItem(
            icon: isDarkMode(context)
                ? Ico.ScheduleStatisticsDark
                : Ico.ScheduleStatistics,
            title: '日程统计',
          ),
          SchedulePageDrawerItem(
            icon: isDarkMode(context) ? Ico.AnniversaryDark : Ico.Anniversary,
            title: '纪念日',
          ),
          // SchedulePageDrawerItem(
          //   icon: Ico.Bin,
          //   title: '废纸篓',
          // ),
          SchedulePageDrawerItem(
            icon: isDarkMode(context) ? Ico.ContactUsDark : Ico.ContactUs,
            title: '联系我们',
          ),
          SchedulePageDrawerItem(
            icon: isDarkMode(context) ? Ico.LightMode : Ico.DarkMode,
            title: '${isDarkMode(context) ? '日' : '夜'}间模式',
            onTap: () => themeProvider.changeTheme(
              isDarkMode(context) ? ThemeMode.light : ThemeMode.dark,
            ),
          ),
        ],
      ),
    );
  }
}
