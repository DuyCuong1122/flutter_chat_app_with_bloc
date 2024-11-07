import 'dart:convert';
import 'dart:developer';
import 'package:chat_app/common/config/firebase_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

class FirebaseMessagingApi {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static Future<void> init() async {
    await messaging.setAutoInitEnabled(true);
    // Request permission for iOS
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      announcement: false,
    );

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
    } else {
      log('User declined or has not accepted permission');
    }

    // Get the token and update Firestore
    String? token = await messaging.getToken();
    if (token != null) {
      await _storeFcmTokenLocally(token);
    }

    // Listen for token refresh
    messaging.onTokenRefresh.listen((newToken) async {
      await _storeFcmTokenLocally(newToken);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('foreground message');
      log('Got a message whilst in the foreground!');
      log('Message data: ${message.data}');

      if (message.notification != null) {
        log('Message also contained a notification: ${message.notification}');
        // LocalNotifications.showNotification(
        //   title: message.notification?.title,
        //   body: message.notification?.body,
        //   payload: message.data.toString(),
        // );
      }
    });

    // Handle background messages
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
      if (message != null) {
        log('Title: ${message.notification!.title}');
        log('Body: ${message.notification!.body}');
        log('Payload: ${message.data}');
        String tripId = message.data['tripId'];
        log('Trip ID: $tripId');
      }
    });
  }

  static Future<void> _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id', // Replace with your channel id
      'your_channel_name', // Replace with your channel name
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title ?? '',
      message.notification?.body ?? '',
      platformChannelSpecifics,
    );
  }

  static Future<void> _storeFcmTokenLocally(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('fcmtoken', token);
    log('FCM Token stored locally: $token');
  }

  static Future<void> updateFcmTokenInFirestore(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('fcmtoken');
    if (token != null) {
      String id = await FirebaseApi.getDocumentId('users', 'id', userId) ?? "";
      await _firestore.collection('users').doc(id).update({
        'fcmtoken': token,
      });
      log('FCM Token updated for user: $userId');
    }
  }

  static Future sendMessage(String fcmtoken, String title, String body,
      String type, String page, String uid, String status,
      {String? diagnosticId, String? medicalId}) async {
    final String serverkey = await getAccessToken();
    const String endpointCloudMessaging =
        'https://fcm.googleapis.com/v1/projects/hfa---health-for-all/messages:send';
    final Map<String, dynamic> data = {
      'message': {
        "token": fcmtoken,
        'notification': {"title": title, "body": body},
        'data': {"page": page, 'type': type, 'status': status}
      }
    };
    try {
      await http
          .post(Uri.parse(endpointCloudMessaging),
              body: jsonEncode(data),
              headers: <String, String>{
                "Content-Type": 'application/json',
                "Authorization": 'Bearer $serverkey'
              })
          .then((response) => log('thanh cong gui tin nhan$response'))
          .catchError((e) => log(e.toString()));
      // notiController.addNoti(title, body, page, type, uid, status,
      //     diagnosticId: diagnosticId, medicalId: medicalId);
    } catch (e) {
      log('Error sending message: $e');
    }
  }

  static Future<String> getAccessToken() async {
    final serviceAccount = dotenv.env['SERVICE_ACCOUNT_JSON']!;

    List<String> scopes = [
      'https://www.googleapis.com/auth/firebase.messaging',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/userinfo.email'
    ];

    final auth.ServiceAccountCredentials credentials =
        auth.ServiceAccountCredentials.fromJson(serviceAccount);

    final http.Client client = http.Client();
    final auth.AccessCredentials accessCredentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
      credentials,
      scopes,
      client,
    );

    client.close();
    return accessCredentials.accessToken.data;
  }
}