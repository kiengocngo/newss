import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:news_app/app_translations.dart';
import 'package:news_app/bloc/news/news_cubit.dart';
import 'package:news_app/bloc/news_for_you/news_topic_cubit.dart';
import 'package:news_app/bloc/news_topic/entertainment/news_enteratainment_cubit.dart';
import 'package:news_app/bloc/news_topic/sport/news_sports_cubit.dart';
import 'package:news_app/bloc/news_topic/technology/news_technology_cubit.dart';
import 'package:news_app/blocs/info_changes_bloc/info_changes_bloc.dart';
import 'package:news_app/blocs/log_in_bloc/log_in_bloc.dart';
import 'package:news_app/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:news_app/cubit/image_cubit.dart';
import 'package:news_app/firebase_options.dart';
import 'package:news_app/src/routes/app_routes.dart';


import 'package:news_app/blocs/change_password_bloc/change_password_bloc.dart';
import 'package:news_app/blocs/get_users_bloc/get_users_bloc.dart';
import 'package:news_app/blocs/update_users_bloc/update_users_bloc.dart';
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

        BlocProvider<SignUpBloc>(create: (context) => SignUpBloc()),
        BlocProvider<ImageCubit>(create: (context) => ImageCubit()),
        BlocProvider<InfoChangesBloc>(create: (context) => InfoChangesBloc()),
        BlocProvider(create: (BuildContext context) => NewsCubit(dio: Dio())),
        BlocProvider(
            create: (BuildContext context) => NewsTopicsCubit(dio: Dio())),
        BlocProvider(
            create: (BuildContext context) =>
                NewsEntertainmentCubit(dio: Dio())),
        BlocProvider(
            create: (BuildContext context) => NewsSportsCubit(dio: Dio())),
        BlocProvider(
            create: (BuildContext context) => NewsTechnologyCubit(dio: Dio())),
              BlocProvider(create: (context) => ImageCubit()),
        BlocProvider(create: (context) => UpdateUsersBloc()),
        BlocProvider(create: (context) => GetUserBloc()),
        BlocProvider(create: (context) => ChangePasswordBloc()),
      ],
      child: GetMaterialApp(
        theme: ThemeData(),
        initialRoute: '/splash',
        routes: AppRoutes.routes,
        debugShowCheckedModeBanner: false,
        translations: AppTranslation(),
        locale: Get.deviceLocale,
      


      ),
    );
  }
}
