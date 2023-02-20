import 'package:bestengineer/services/fcm_navigation_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';

class FcmService {
  String token = "";

  /// Create a [AndroidNotificationChannel] for heads up notifications
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
      playSound: true);

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> initialize() async {
    _getPermissions();
    getFirebaseTokken();
    _initializeBackgroundMsg();
    _initializeLocalNotification();
    _handleMesgOnTerminatedState();
    _foregroundNotification();
  }

  _getPermissions() async {
    try {
      await _fcm.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    } catch (_) {}
  }

  Future<String> getFirebaseTokken() async {
    try {
      token = (await _fcm.getToken())!;
      print("token fromfcm------$token");
    } catch (_) {}

    return token;
  }

  _initializeBackgroundMsg() async {
    // Set the background messaging handler early on, as a named top-level function
    try {
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
      
    } catch (_) {}
  }

  _initializeLocalNotification() async {
    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await _fcm.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  

  _foregroundNotification() async {
    try {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null && !kIsWeb) {
          var android =
              const AndroidInitializationSettings('drawable/ic_notification');
          var ios = const DarwinInitializationSettings(
              defaultPresentSound: true, requestSoundPermission: true);
          var platform = InitializationSettings(android: android, iOS: ios);
          _flutterLocalNotificationsPlugin.initialize(
            platform,
            onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
            onDidReceiveBackgroundNotificationResponse:
                _onDidReceiveBackgroundNotificationResponse,
          );
          // _onSelectLocalNotification
          _flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    channelDescription: channel.description,
                    icon: 'drawable/ic_notification',
                    color: Colors.green,
                    importance: channel.importance,
                    playSound: channel.playSound),
              ),
              payload: message.data["payload"]);
        }
      });
    } catch (_) {}

    try {
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        FcmNavigationService(page: message.data["payload"]).navigateToPage();
      });
    } catch (_) {}
  }

  _handleMesgOnTerminatedState() async {
    _fcm.getInitialMessage().then((RemoteMessage? message) async {
      if (message != null) {
        await Future.delayed(const Duration(seconds: 5));
        FcmNavigationService(page: message.data["payload"]).navigateToPage();
      }
    });
  }

  Future<dynamic> _onSelectLocalNotification(String? page) {
    return FcmNavigationService(page: page).navigateToPage();
  }

  void _onDidReceiveNotificationResponse(NotificationResponse details) {
    _onSelectLocalNotification(details.payload);
  }

  void _onDidReceiveBackgroundNotificationResponse(
      NotificationResponse details) {
    _onSelectLocalNotification(details.payload);
  }
}
