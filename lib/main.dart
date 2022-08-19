import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/ui/bottom_navigator/bottom_navigator_screen.dart';
import 'package:news_app/src/ui/notifications_screen/notifications_services.dart';
import 'package:news_app/src/ui/settings/settings_screen.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale("en"), Locale("vi")],
      path: 'assets/translations',
      startLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'settings': ((context) => const SettingsScreen()),
      },
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(),
      home: const BottomNavigationScreen(),
    );
  }
}
