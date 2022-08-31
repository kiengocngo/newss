import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/models/notifications_model/notifications_model.dart';
import 'package:news_app/src/ui/notifications_screen/notifications_services.dart';
import 'package:news_app/src/ui/settings/settings_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late AndroidNotificationChannel channel;
  late final LocalNotificationService service;

  late final FirebaseMessaging messaging;
  PushNotifications? pushNotificationsInfo;
  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  void listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotifications notification = PushNotifications(
          title: message.notification!.title!,
          body: message.notification!.body!,
          time: message.sentTime!,
          routeName: message.data['routePage']);

      Navigator.push(
          context, MaterialPageRoute(builder: (_) => SettingsScreen()));

      setState(() {
        pushNotificationsInfo = notification;
      });
    });
  }

  void loadFCM() async {
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        enableVibration: true,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  void sendPushMessage(String token, String body, String title) async {
    try {
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAAmqbb3Hs:APA91bFBO4Q7jKHArvQTfwaYZleWe1cfFH3j22jCk6BNSnqA44DUbIO56tuezEJMDocnoG0BHrJLGvth-p2ID_JgYeceFZquZzsM3HjC-bgD9UBEUov6bTV90waUmJ2PnJ_m4LBKZSeu',
          },
          body: jsonEncode(<String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            'to': token,
          }));
    } catch (e) {
      log('err push');
    }
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      print('Token => $token ');
    });
  }

  @override
  void initState() {
    requestPermission();

    loadFCM();
    listenFCM();
    getToken();
    _titleController.text = 'kien';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        children: [
          TextFormField(
            controller: _titleController,
          ),
          TextFormField(
            controller: _bodyController,
          ),
          ElevatedButton(
              onPressed: () {
                String body = _bodyController.text;
                String title = _titleController.text;
                sendPushMessage(
                  'ca--l7x7RGKxbxtA31gF-8:APA91bHw-KLhOiKnEP8ZiD0YPCKnuZHQGWN0ZEozpzEVmEBOFRJ0sclfzzi1FX31rIcAaFOiwijRG4woDKfBBXvcQ7OFMBTZQjmg3KDLfh9y47u7OsllaHr0RHrX-xsIeQ-xH2cThZBT',
                  body,
                  title,
                );
                _bodyController.clear();
                _titleController.clear();
              },
              child: const Text('Click'))
        ],
      ),
    ));
  }

  void listenToNotification() =>
      service.onNotificationClick.stream.listen(onNoticationListener);
  void onNoticationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      print(payload);
      if (payload == 'settings') {
        Navigator.pushNamed(context, 'settings');
      } else if (payload == 'home') {
        Navigator.pushNamed(context, 'home');
      }
    }
  }
}
