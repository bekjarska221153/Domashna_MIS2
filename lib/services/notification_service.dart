import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import '../main.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin
  _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings =
    InitializationSettings(android: androidSettings);

    await _flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) {
        navigatorKey.currentState?.pushNamed('/random-recipe');
      },
    );

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'daily_recipe_channel',
      'Daily Recipe',
      description: 'Daily recipe reminder',
      importance: Importance.high,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static Future<void> scheduleDailyRecipeNotification() async {
    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'daily_recipe_channel',
      'Daily Recipe',
      channelDescription: 'Daily recipe reminder',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails details =
    NotificationDetails(android: androidDetails);

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      101,
      '🍽 Recipe of the Day',
      'Tap to see today\'s random recipe!',
      tz.TZDateTime.now(tz.local).add(const Duration(minutes: 1)),
      details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
  /*
  static Future<void> showRecipeNotification() async {
    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'daily_recipe_channel',
      'Daily Recipe',
      channelDescription: 'Daily recipe reminder',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails details =
    NotificationDetails(android: androidDetails);

    await _flutterLocalNotificationsPlugin.show(
      1,
      '🍽 Recipe of the Day',
      'Tap to see today\'s random recipe!',
      details,
    );
  }
*/
  static tz.TZDateTime _nextInstanceOfFourPM() {
    final now = tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduled =
    tz.TZDateTime(tz.local, now.year, now.month, now.day, 16);

    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    return scheduled;
  }
}
