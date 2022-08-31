import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/models/notifications_model/notifications_model.dart';
import 'package:news_app/src/ui/notifications_screen/notifications_services.dart';

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

  List<PushNotifications> list = [
    PushNotifications(
      routeName: 'settings',
      title: 'Thong bao A',
      body: 'Noi dung thong bao A',
      time: DateTime.now(),
      image:
          'https://thumbs.dreamstime.com/z/happy-smiling-geek-hipster-beard-man-cool-avatar-geek-man-avatar-104871313.jpg',
    ),
  ];
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

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
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

  void registerNotification() async {
    await Firebase.initializeApp();
    messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('user granted');
      FirebaseMessaging.instance.getInitialMessage().then((message) {
        if (message != null) {
          final routeFromMessage = message.data["routePage"];
          PushNotifications notification = PushNotifications(
              image: message.data['image'],
              title: message.notification!.title!,
              body: message.notification!.body!,
              time: message.sentTime!,
              routeName: message.data['routePage']);
          Navigator.of(context).pushNamed(routeFromMessage);
          setState(() {
            pushNotificationsInfo = notification;
            list.add(pushNotificationsInfo!);
            list.sort((b, a) => a.time.compareTo(b.time));
          });
        }
      });

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        PushNotifications notification = PushNotifications(
            image: message.data['image'],
            title: message.notification!.title!,
            body: message.notification!.body!,
            time: message.sentTime!,
            routeName: message.data['routePage']);
        var routeName = message.data['routePage'];
        service.displayNotifications(1, message.notification!.title!,
            message.notification!.body!, routeName);

        setState(() {
          pushNotificationsInfo = notification;
          list.add(pushNotificationsInfo!);
          list.sort((b, a) => a.time.compareTo(b.time));
        });
      });
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        PushNotifications notification = PushNotifications(
            image: message.data['image'],
            title: message.notification!.title!,
            body: message.notification!.body!,
            time: message.sentTime!,
            routeName: message.data['routePage']);
        final routeMessage = message.data['routePage'];
        Navigator.pushNamed(context, routeMessage);

        setState(() {
          pushNotificationsInfo = notification;
          list.add(pushNotificationsInfo!);
          list.sort((b, a) => a.time.compareTo(b.time));
        });
      });
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
      print(token);
    });
  }

  @override
  void initState() {
    requestPermission();
    loadFCM();
    listenFCM();
    // service = LocalNotificationService();
    // service.intialize();
    // super.initState();
    // registerNotification();
    // listenToNotification();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        children: [
          // SizedBox(
          //   height: MediaQuery.of(context).size.height * 0.75,
          //   child: ListView.builder(
          //       itemCount: list.length,
          //       itemBuilder: (context, index) {
          //         return NotiItems(
          //             title: list[index].title,
          //             dataTime: list[index].time,
          //             image: list[index].image,
          //             body: list[index].body,
          //             onTap: () {
          //               Navigator.pushNamed(context, list[index].routeName);
          //             });
          //       }),
          // ),
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
                    'f3HnRzuBRn6o9ehOVTzcnq:APA91bHZyyYYB4X9HKfJK1cac4mW-2G85IsU7G9WC0IyojOYqInM1pE6JcAhWUZIBPis28qmGL87V5ftLadR3jzTSTbXlAfx01CdVmSvB2Sc1vxNWGDMrc4AcR7VMX7KhJzoaLEGmcfp',
                    body,
                    title);
                // final user = FirebaseAuth.instance.currentUser;
                // if (user != null) {
                //   final name = user.uid;
                //   print(name);
                //   service.showNotification(id: 0, title: 'Title', body: 'body');
                // } else {
                //   print('nulllll');
                // }
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
