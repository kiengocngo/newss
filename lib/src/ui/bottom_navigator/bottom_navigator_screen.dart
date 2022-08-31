import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/src/ui/chat/screens/conversation.dart';
import 'package:news_app/src/ui/favorite/favorite.dart';
import 'package:news_app/src/ui/home/home_screen.dart';
import 'package:news_app/src/ui/notifications_screen/notification_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ConversationScreen(),
    FavoriteScreen(),
    NotificationScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  Container buildBottomNavigationBar(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: Colors.white60,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                });
              },
              child: Column(
                children: [
                  _selectedIndex == 0
                      ? const Icon(
                          CupertinoIcons.home,
                          color: Colors.black,
                          size: 25,
                        )
                      : const Icon(
                          CupertinoIcons.home,
                          color: Colors.grey,
                          size: 25,
                        ),
                  Text(
                    ('home'.tr),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = 1;
                });
              },
              child: Column(
                children: [
                  _selectedIndex == 1
                      ? const Icon(
                          CupertinoIcons.chat_bubble_2,
                          color: Colors.black,
                          size: 25,
                        )
                      : const Icon(
                          CupertinoIcons.chat_bubble_2,
                          color: Colors.grey,
                          size: 25,
                        ),
                  Text(
                    ('message'.tr),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = 2;
                });
              },
              child: Column(
                children: [
                  _selectedIndex == 2
                      ? const Icon(
                          CupertinoIcons.heart,
                          color: Colors.black,
                          size: 25,
                        )
                      : const Icon(
                          CupertinoIcons.heart,
                          color: Colors.grey,
                          size: 25,
                        ),
                  Text(
                    ('follow'.tr),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = 3;
                });
              },
              child: Column(
                children: [
                  _selectedIndex == 3
                      ? const Icon(
                          CupertinoIcons.bell,
                          color: Colors.black,
                          size: 25,
                        )
                      : const Icon(
                          CupertinoIcons.bell,
                          color: Colors.grey,
                          size: 25,
                        ),
                  Text(
                    ('noti'.tr),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
