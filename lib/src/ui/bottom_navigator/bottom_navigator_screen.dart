import 'package:badges/badges.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/ui/home/home_screen.dart';
import 'package:news_app/src/ui/notifications_screen/notification_screen.dart';
import 'package:news_app/src/ui/settings/settings_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IndexedStack(
          index: _selectedIndex,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            // ignore: prefer_const_constructors
            HomeScreen(
              
            ),
            // ignore: prefer_const_constructors
            Text(
              'Index 2: Chat',
            ),
            // ignore: prefer_const_constructors
            Text('Favourite'),
            // ignore: prefer_const_constructors
            NotificationScreen(),
            // ignore: prefer_const_constructors
            SettingsScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.green,
            ),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.chat_bubble_outline_rounded,
              color: Colors.green,
            ),
            label: 'Chat',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_rounded,
              color: Colors.green,
            ),
            label: 'Favourite',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              position: BadgePosition.topEnd(),
              badgeColor: const Color.fromARGB(255, 235, 161, 156),
              badgeContent: const Text('4'),
              animationDuration: const Duration(seconds: 1),
              animationType: BadgeAnimationType.fade,
              child: const Icon(
                Icons.notification_important_rounded,
                color: Colors.green,
              ),
            ),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.settings,
              color: Colors.green,
            ),
            label: tr('Settings'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[700],
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
