import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/components/noti_item/noti_items.dart';
import 'package:news_app/src/models/notifications_model/notifications_model.dart';
import 'package:news_app/src/ui/notifications_screen/notifications_services.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late final LocalNotificationService service;
  List<PushNotifications> list = [
    PushNotifications(
      routeName: 'settings',
      title: 'Thong bao A',
      body: 'Noi dung thong bao A',
      //type: 'A',
      time: DateTime.now(),
      image:
          'https://thumbs.dreamstime.com/z/happy-smiling-geek-hipster-beard-man-cool-avatar-geek-man-avatar-104871313.jpg',
    ),
  ];
  late final FirebaseMessaging messaging;
  PushNotifications? pushNotificationsInfo;
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

  @override
  void initState() {
    service = LocalNotificationService();
    service.intialize();
    super.initState();
    registerNotification();
    listenToNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return NotiItems(
                      title: list[index].title,
                      dataTime: list[index].time,
                      image: list[index].image,
                      body: list[index].body,
                      onTap: () {
                        Navigator.pushNamed(context, list[index].routeName);
                      });
                }),
          ),
          ElevatedButton(
              onPressed: () {
                final user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  final name = user.uid;
                } else {
                }
                service.showNotification(id: 0, title: 'Title', body: 'body');
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
      if (payload == 'settings') {
        Navigator.pushNamed(context, 'settings');
      } else if (payload == 'home') {
        Navigator.pushNamed(context, 'home');
      }
    }
  }
}
