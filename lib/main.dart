import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:news_app/app_translations.dart';
import 'package:news_app/blocs/change_password_bloc/change_password_bloc.dart';
import 'package:news_app/blocs/get_users_bloc/get_users_bloc.dart';
import 'package:news_app/blocs/update_users_bloc/update_users_bloc.dart';
import 'package:news_app/cubit/image_cubit.dart';
import 'package:news_app/firebase_options.dart';
import 'package:news_app/src/ui/bottom_navigator/bottom_navigator_screen.dart';
import 'package:news_app/src/ui/home/home_screen.dart';
import 'package:news_app/src/ui/login/login_screen.dart';
import 'package:news_app/src/ui/settings/settings_screen.dart';

import 'blocs/log_in_bloc/log_in_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LogInBloc>(create: (context) => LogInBloc()),
        BlocProvider(create: (context) => ImageCubit()),
        BlocProvider(create: (context) => UpdateUsersBloc()),
        BlocProvider(create: (context) => GetUsersBloc()),
        BlocProvider(create: (context) => ChangePasswordBloc()),
      ],
      child: GetMaterialApp(
        translations: AppTranslation(),
        locale: Get.deviceLocale,
        initialRoute: '/bottom',
        routes: {
          '/home': (context) => const HomeScreen(),
          'settings': ((context) => const SettingsScreen()),
          '/login': (context) => LoginScreen(),
          '/bottom': (context) => const MainScreen(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        // home: const BottomNavigationScreen(),
      ),
    );
  }
}
