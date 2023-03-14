import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:doit/utils/show_confirm_dialog.dart';

Future<void> creatNotification(
  int id,
  String title,
  String body, {
  DateTime? scheduleTime,
}) async =>
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'basic_channel',
        title: title,
        body: body,
        // notificationLayout: NotificationLayout.Default,
      ),
      // actionButtons: [
      //   NotificationActionButton(
      //     key: 'MARK_DONE',
      //     label: 'Mark Done',
      //   ),
      // ],
      schedule: scheduleTime != null
          ? NotificationCalendar(
              year: scheduleTime.year,
              month: scheduleTime.month,
              day: scheduleTime.day,
              hour: scheduleTime.hour,
              minute: scheduleTime.minute,
              allowWhileIdle: true,
              // repeats: true,
            )
          : null,
    );

Future<void> cancelScheduledNotification(int id) async =>
    await AwesomeNotifications().cancelSchedule(id);

Future<void> authorizeNotification(BuildContext context) {
  Completer<void> completer = Completer();
  AwesomeNotifications().isNotificationAllowed().then(
    (isAllowed) {
      if (!isAllowed) {
        showConfirmDialog(
          '为了能及时提醒到您，DOIT 需要获取您的通知权限。',
          context: context,
          confirmText: '前往授权',
          onConfirm: (context) => AwesomeNotifications()
              .requestPermissionToSendNotifications()
              .then(
                (_) => {
                  Navigator.pop(context),
                  completer.complete(),
                },
              ),
        );
      } else {
        completer.complete();
      }
    },
  );
  return completer.future;
}
