import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doit/widgets/tab_bar.dart';
import 'package:doit/routes.dart';

void main() {
  runApp(DOITApp());
  // if (Platform.isAndroid) {
  //   //设置Android头部的导航栏透明
  //   SystemUiOverlayStyle systemUiOverlayStyle =
  //       SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  //   SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  // }
}

class DOITApp extends StatelessWidget {
  final List<BottomNavigationBarItem> tabItems = Routes.getTabBarItems();
  final Map<String, Widget Function(BuildContext)> tabRoutes =
      Routes.getRoutesMap();

  @override
  Widget build(context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return CupertinoApp(
          debugShowCheckedModeBanner: false,
          home: CupertinoTabScaffold(
            tabBar: tabBar(Routes.getTabBarItems()),
            tabBuilder: (context, index) {
              return CupertinoTabView(
                routes: tabRoutes,
                builder: (context) => Routes.pages[index].viewWidget(context),
              );
            },
          ),
        );
      },
    );
  }
}
