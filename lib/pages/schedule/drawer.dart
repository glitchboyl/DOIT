import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doit/constants/meas.dart';
import 'drawer_item.dart';

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
            // ExpansionTile(
            //   backgroundColor: Colors.blue,
            //   tilePadding: EdgeInsets.all(0),
            //   childrenPadding: EdgeInsets.all(0),
            //   title: Container(color: Colors.red, child: Text('展开闭合demo')),
            //   // trailing: Text('qweqwe'),
            //   // backgroundColor: Colors.white,
            //   initiallyExpanded: true, // 是否默认展开
            //   children: <Widget>[
            //     ListTile(title: Text('北京优帆远扬'), subtitle: Text('重庆优帆天成')),
            //     ListTile(title: Text('北京优帆远扬'), subtitle: Text('重庆优帆天成'))
            //   ],
            // )
          ],
        ),
      );
}
