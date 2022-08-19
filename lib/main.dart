import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news/news_cubit.dart';
import 'package:news_app/bloc/news/news_page/page1_cubit.dart';
import 'package:news_app/bloc/news_topic/news_cubit_entertainment.dart';
import 'package:news_app/bloc/news_topic/news_cubit_sports.dart';
import 'package:news_app/bloc/news_topic/news_cubit_technology.dart';
import 'package:news_app/src/routes/app_routes.dart';
import 'bloc/news/news_page/page2_cubit.dart';
import 'bloc/news/news_page/page3_cubit.dart';
import 'bloc/news/news_page/page4_cubit.dart';
import 'bloc/news/news_page/page5_cubit.dart';
import 'bloc/news/news_page/page6_cubit.dart';
import 'bloc/news_for_you/news_topic_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => NewsCubit(dio: Dio())),
        BlocProvider(
            create: (BuildContext context) => NewsTopicsCubit(dio: Dio())),
        BlocProvider(
            create: (BuildContext context) => NewsCubitSprots(dio: Dio())),
        BlocProvider(
            create: (BuildContext context) => NewsCubitTechnology(dio: Dio())),
        BlocProvider(
            create: (BuildContext context) =>
                NewsCubitEntertainment(dio: Dio())),
        BlocProvider(create: (BuildContext context) => Page1Cubit(dio: Dio())),
        BlocProvider(create: (BuildContext context) => Page2Cubit(dio: Dio())),
        BlocProvider(create: (BuildContext context) => Page3Cubit(dio: Dio())),
        BlocProvider(create: (BuildContext context) => Page4Cubit(dio: Dio())),
        BlocProvider(create: (BuildContext context) => Page5Cubit(dio: Dio())),
        BlocProvider(create: (BuildContext context) => Page6Cubit(dio: Dio())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        initialRoute: '/splash',
        routes: AppRoutes.routes,
      ),
    );
  }
}
