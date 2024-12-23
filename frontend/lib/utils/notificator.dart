import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notificator {
  static Notificator? _instance;

  late final FlutterLocalNotificationsPlugin _plugin;

  int id = 1;

  static Notificator get() {
    _instance ??= Notificator._();
    return _instance!;
  }

  Notificator._() {
    _plugin = FlutterLocalNotificationsPlugin();
  }

  notify(String title, String body) {
    _plugin.show(
        id++,
        title,
        body,
        const NotificationDetails(
            android: AndroidNotificationDetails("news", "news")));
  }
}
