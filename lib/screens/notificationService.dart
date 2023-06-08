import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
// import '../screens/notification/notification_screen.dart';
// import 'navigation_service.dart';

class NotificationService {
  static final NotificationService _notificationService =
  NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  final AndroidNotificationChannel channel = AndroidNotificationChannel(
    'Tastesonway Owner', // id
    'Importance Notifications', // title
    description:
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  bool isFlutterLocalNotificationsInitialized = false;

  Future<String?> getFirebaseToken() async {
    String? firebaseToken = await FirebaseMessaging.instance.getToken();
    return firebaseToken;
  }

  Future<void> setupFlutterNotifications() async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    isFlutterLocalNotificationsInitialized = true;
  }

  void showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            // TODO add a proper drawable resource to android, for now using
            //      one that already exists in example app.
            icon: '@mipmap/ic_launcher',
          ),
        ),
      );
    }
  }

  void onMessageNotification() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("onMessage: $message");
      showNotifications(message);
      onNotificationClick();
    });
  }

  Future<void> onNotificationClick() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      // await Navigator.push(NavigationService.navigatorKey.currentContext,
      //     MaterialPageRoute(builder: (context) => NotificationScreen()));
    });
  }

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    // final IOSInitializationSettings initializationSettingsIOS =
    // IOSInitializationSettings(
    //   requestSoundPermission: false,
    //   requestBadgePermission: false,
    //   requestAlertPermission: false,
    // );

    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        // iOS: initializationSettingsIOS,
        macOS: null);

    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: selectNotification,
        onDidReceiveBackgroundNotificationResponse: selectNotification);
  }

  AndroidNotificationDetails _androidNotificationDetails =
  AndroidNotificationDetails(
    'channel ID',
    'channel name',
    playSound: true,
    priority: Priority.high,
    importance: Importance.high,
  );

  Future<void> showNotifications(RemoteMessage message) async {
    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      NotificationDetails(android: _androidNotificationDetails),
    );
  }

  Future<void> scheduleNotifications() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        "Notification Title",
        "This is the Notification Body!",
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        NotificationDetails(android: _androidNotificationDetails),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> cancelNotifications(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

selectNotification(NotificationResponse message) async {
  if (message != null) {
    // print(message.payload['order_id']);
    // print(message.data['Bank_Status']);
    // print(message.data['notification_type']);
    // if (message != null) {
    //   if (message.data != null) {
    //     if (message.data['order_id'] != null) {
    //       SchedulerBinding.instance.addPostFrameCallback((_) {
    //         Navigator.of(GlobalVariable.navState.currentContext)
    //             .push(MaterialPageRoute(
    //             builder: (context) => OrderReceivedDetailsScreen(
    //               orderID: int.parse(
    //                   message.data['order_id'].toString()),
    //             )))
    //             .whenComplete(getDashbaordDetails);
    //       });
    //     } else if (message.data['notification_type'] != null) {
    //       SchedulerBinding.instance.addPostFrameCallback((_) {
    //         Navigator.of(GlobalVariable.navState.currentContext)
    //             .push(MaterialPageRoute(
    //             builder: (context) => ReviewHistoryScreen()))
    //             .whenComplete(getDashbaordDetails);
    //       });
    //     }
    //   }
    // }
    // await Navigator.push(NavigationService.navigatorKey.currentContext,
    //     MaterialPageRoute(builder: (context) => NotificationScreen()));
  }
}
