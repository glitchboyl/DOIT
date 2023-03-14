import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:provider/provider.dart';
import 'pages/note/index.dart';
import 'pages/note_publish/index.dart';
// import 'pages/schedule/drawer.dart';
import 'widgets/app_bar.dart';
import 'widgets/add_button.dart';
import 'widgets/bottom_navigation_bar.dart';
import 'widgets/svg_icon.dart';
import 'providers/db.dart';
import 'providers/to_do_list.dart';
import 'providers/note.dart';
import 'providers/bookkeeping.dart';
import 'models/navigation.dart';
import 'models/floating_action_button_location.dart';
import 'models/floating_action_button_animator.dart';
import 'constants/styles.dart';
import 'constants/meas.dart';
import 'constants/keys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _toDoListProvider = ToDoListProvider();
  final _noteProvider = NoteProvider();
  final _bookkeepingProvider = BookkeepingProvider();
  await connectDB();
  _toDoListProvider.get();
  _noteProvider.get();
  _bookkeepingProvider.get();
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  AwesomeNotifications().initialize(
    'resource://drawable/launcher_icon',
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        channelDescription: 'Basic Notifications',
        importance: NotificationImportance.High,
        channelShowBadge: true,
      ),
    ],
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => _toDoListProvider),
        ChangeNotifierProvider(create: (context) => _noteProvider),
        ChangeNotifierProvider(create: (context) => _bookkeepingProvider),
      ],
      child: DOITApp(),
    ),
  );
}

class DOITApp extends StatefulWidget {
  @override
  _DOITAppState createState() => _DOITAppState();
}

class _DOITAppState extends State<DOITApp> {
  int _currentIndex = 0;
  List<BottomNavigationBarItem> _navigationBarItems = [];
  final List<AppBarBuilder> _appBarWidgets = [];
  final List<Widget> _pageWidgets = [];

  @override
  void initState() {
    super.initState();
    AwesomeNotifications().actionStream.listen((notification) {
      if (notification.channelKey == 'basic_channel' && Platform.isIOS) {
        AwesomeNotifications().getGlobalBadgeCounter().then(
              (value) =>
                  AwesomeNotifications().setGlobalBadgeCounter(value - 1),
            );
      }
    });
    for (int i = 0; i < navigation.length; i++) {
      final page = navigation[i];
      _navigationBarItems.add(
        BottomNavigationBarItem(
          icon: SVGIcon(
            page.icon,
            width: MEAS.bottomNavigationBarIconLength,
            height: MEAS.bottomNavigationBarIconLength,
          ),
          activeIcon: SVGIcon(
            page.activeIcon,
            width: MEAS.bottomNavigationBarIconLength,
            height: MEAS.bottomNavigationBarIconLength,
          ),
          label: '',
        ),
      );
      _appBarWidgets.add(page.appBar());
      _pageWidgets.add(page.widget());
    }
  }

  @override
  void dispose() {
    AwesomeNotifications().actionSink.close();
    AwesomeNotifications().createdSink.close();
    super.dispose();
  }

  @override
  Widget build(context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          fontFamily: 'Barlow',
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          applyElevationOverlayColor: false,
          splashFactory: NoSplash.splashFactory,
          scaffoldBackgroundColor: Styles.BackgroundColor,
          primaryColor: Styles.PrimaryColor,
        ),
        themeMode: ThemeMode.light,
        home: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: _appBarWidgets[_currentIndex],
          body: IndexedStack(index: _currentIndex, children: _pageWidgets),
          // drawerScrimColor: Styles.BarrierColor,
          // drawer: SchedulePageDrawer(),
          // drawerEnableOpenDragGesture: false,
          floatingActionButton: AddButton(
            navigation[_currentIndex].id,
            key: Keys.AddButton,
          ),
          floatingActionButtonLocation: FABLocation(
            location: FloatingActionButtonLocation.endDocked,
            offsetX: -16,
            offsetY: -MEAS.bottomNavigationBarHeight - MEAS.addButtonBottom,
          ),
          floatingActionButtonAnimator: FABAnimator(),
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: BottomNavigationBarBuilder(
            items: _navigationBarItems,
            currentIndex: _currentIndex,
            onTap: (int index) {
              if (_currentIndex != index) {
                Provider.of<ToDoListProvider>(
                  context,
                  listen: false,
                ).currentPage(index);
                setState(() {
                  _currentIndex = index;
                });
              }
            },
          ),
        ),
        routes: {
          '/note': (context) => NotePage(),
          '/note_publish': (context) => NotePublishPage(),
        },
      );
}
