import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/presentation/journey/main/main_controller.dart';

import 'package:permission_handler/permission_handler.dart';

class LocalNotificationService {
  static Future<ByteArrayAndroidBitmap> getImageBytes(String imageUrl) async {
    final bytes = (await rootBundle.load(imageUrl)).buffer.asUint8List();
    final androidBitMap =
        ByteArrayAndroidBitmap.fromBase64String(base64.encode(bytes));
    return androidBitMap;
  }

  static void setupNotification(
      {required String title,
      required String content,
      required int notiId,
      String? androidIconPath,
      String? payload}) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestPermission();
    // final curentTimeZone = tz.getLocation('Asia/Ho_Chi_Minh');
    //
    // final scheduleTime = tz.TZDateTime(
    //     curentTimeZone,
    //     scheduleDateTime.year,
    //     scheduleDateTime.month,
    //     scheduleDateTime.day,
    //     scheduleDateTime.hour,
    //     scheduleDateTime.minute,
    //     scheduleDateTime.second);
    //
    // final tzTimeSchedule = tz.TZDateTime.from(
    //   scheduleTime,
    //   curentTimeZone,
    // );

    flutterLocalNotificationsPlugin.show(
      notiId,
      title,
      content,
      NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            channelDescription: '',
            icon: androidIconPath ?? "@mipmap/ic_launcher",
            priority: Priority.high,
            importance: Importance.max,
            largeIcon:
                const DrawableResourceAndroidBitmap("@mipmap/ic_launcher"),
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
            sound: "default",
          )),
      payload: payload,
    );
    debugPrint('-------Notification Added with ID: $notiId--------');
  }

  static onDidReceiveLocalNotification(i1, s1, s2, s3) {}

  static void initNotificationLocal() async {
    debugPrint('##########3');
    await Permission.notification.request();
    debugPrint('##########3');
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onTapNotification);

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(AndroidNotificationChannel(
          'high_importance_channel',
          'High Importance Notifications',
          importance: Importance.max,
        ));
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  static void onTapNotification(NotificationResponse notificationResponse) {
    Get
      ..until((route) => Get.currentRoute == AppRoutes.main)
      ..find<MainController>().onChangedNav(3);
  }
}
