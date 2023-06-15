import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tastesonway/screens/orders/order_details.dart';
import 'package:tastesonway/screens/review%20history/review_history.dart';
import 'package:tastesonway/utils/global_variable.dart';
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
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  bool isFlutterLocalNotificationsInitialized = false;

  Future<String?> getFirebaseToken() async {
    String? firebaseToken = await FirebaseMessaging.instance.getToken();
    print("this is firebase token:    $firebaseToken");
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
          iOS: const DarwinNotificationDetails(),
        ),
      );
    }
  }

  void onMessageNotification() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if(message.notification != null) {
        print("onMessage: $message");
        showNotifications(message);
      }
      // onNotificationClick(message);
      // onNotificationClick();
    });
  }

  // navigateOnNotificationCLick(RemoteMessage message) {
  //   print(message.data.toString());
  //   print(message.notification!.title);
  //   print(message.data['order_id']);
  //   print(message.data['Bank_Status']);
  //   print(message.data['notification_type']);
  //   if (message != null) {
  //     if (message.data != null) {
  //       if (message.data['order_id'] != null) {
  //         SchedulerBinding.instance.addPostFrameCallback((_) {
  //           Navigator.push(
  //               GlobalVariable.navState.currentContext!,
  //               MaterialPageRoute(
  //                   builder: (context) => OrderDetails(
  //                         id: int.parse(message.data['order_id'].toString()),
  //                       )));
  //           // .whenComplete(getDashbaordDetails);
  //         });
  //       } else if (message.data['notification_type'] != null) {
  //         print("dfdfddfdfd");
  //         SchedulerBinding.instance.addPostFrameCallback((_) {
  //           Navigator.push(GlobalVariable.navState.currentContext!,
  //               MaterialPageRoute(builder: (context) => const ReviewHistory()));
  //           // .whenComplete(getDashbaordDetails);
  //         });
  //       } else {
  //         SchedulerBinding.instance.addPostFrameCallback((_) {
  //           Navigator.push(GlobalVariable.navState.currentContext!,
  //               MaterialPageRoute(builder: (context) => ReviewHistory()));
  //           // .whenComplete(getDashbaordDetails);
  //         });
  //       }
  //     }else {
  //       SchedulerBinding.instance.addPostFrameCallback((_) {
  //         Navigator.push(GlobalVariable.navState.currentContext!,
  //             MaterialPageRoute(builder: (context) => ReviewHistory()));
  //         // .whenComplete(getDashbaordDetails);
  //       });
  //     }
  //   }
  // }

  Future<void> onNotificationClick() async {
    print("over here");

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      // FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      print(message);

      if (message != null) {
        if (message.data != null) {
          print(message.data.toString());
          print(message.notification!.title);
          print(message.data['order_id']);
          print(message.data['Bank_Status']);
          print(message.data['notification_type']);
          if (message.data['order_id'] != null) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.push(
                  GlobalVariable.navState.currentContext!,
                  MaterialPageRoute(
                      builder: (context) => OrderDetails(
                            id: int.parse(message.data['order_id'].toString()),
                          )));
              // .whenComplete(getDashbaordDetails);
            });
          } else if (message.data['notification_type'] != null) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.push(
                  GlobalVariable.navState.currentContext!,
                  MaterialPageRoute(
                      builder: (context) => const ReviewHistory()));
              // .whenComplete(getDashbaordDetails);
            });
          } else {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.push(GlobalVariable.navState.currentContext!,
                  MaterialPageRoute(builder: (context) => ReviewHistory()));
              // .whenComplete(getDashbaordDetails);
            });
          }
        }
      }
      // await Navigator.push(NavigationService.navigatorKey.currentContext,
      //     MaterialPageRoute(builder: (context) => NotificationScreen()));
    });
  }

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: selectNotification,
        onDidReceiveBackgroundNotificationResponse: selectNotification);
  }

  final AndroidNotificationDetails _androidNotificationDetails =
      const AndroidNotificationDetails(
    'channel ID',
    'channel name',
    // icon: '@mipmap/ic_launcher',
    playSound: true,
    // priority: Priority.high,
    importance: Importance.high,
  );

  Future<void> showNotifications(RemoteMessage message) async {
    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      NotificationDetails(android: _androidNotificationDetails,iOS: const DarwinNotificationDetails()),
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

selectNotification(NotificationResponse notificationResponse) async {
  if (notificationResponse != null) {
    print(notificationResponse.payload);
    print("hereeee2");
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // FirebaseMessaging.instance.getInitialMessage().then((message) {
      print("hereeee3");
      if (message != null) {
        // print(message.data.toString());
        if (message!.data != null) {
          if(message.notification != null) {
            print(message.notification!.title);
            print(message.data['order_id']);
            print(message.data['Bank_Status']);
            print(message.data['notification_type']);

            if (message.data['order_id'] != null) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                Navigator.push(
                    GlobalVariable.navState.currentContext!,
                    MaterialPageRoute(
                        builder: (context) =>
                            OrderDetails(
                              id: int.parse(message.data['order_id']
                                  .toString()),
                            )));
                // .whenComplete(getDashbaordDetails);
              });
            } else if (message.data['notification_type'] != null) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                Navigator.push(GlobalVariable.navState.currentContext!,
                    MaterialPageRoute(builder: (context) => ReviewHistory()));
                // .whenComplete(getDashbaordDetails);
              });
            } else {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                Navigator.push(GlobalVariable.navState.currentContext!,
                    MaterialPageRoute(builder: (context) => ReviewHistory()));
                // .whenComplete(getDashbaordDetails);
              });
            }
          }
        }
      }
    });
  }
}
