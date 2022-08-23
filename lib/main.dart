import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news/more_news/more_news_cubit.dart';
import 'package:news_app/bloc/news/news_cubit.dart';
<<<<<<< HEAD
import 'package:news_app/bloc/news_topic/news_cubit_entertainment.dart';
import 'package:news_app/bloc/news_topic/news_cubit_sports.dart';
import 'package:news_app/bloc/news_topic/news_cubit_technology.dart';
import 'package:news_app/dio/config_dio.dart';
=======
import 'package:news_app/bloc/news_topic/entertainment/news_enteratainment_cubit.dart';
import 'package:news_app/bloc/news_topic/sport/news_sports_cubit.dart';
import 'package:news_app/bloc/news_topic/technology/news_technology_cubit.dart';
>>>>>>> main
import 'package:news_app/src/routes/app_routes.dart';
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
            create: (BuildContext context) =>
                NewsEntertainmentCubit(dio: Dio())),
        BlocProvider(
            create: (BuildContext context) => NewsSportsCubit(dio: Dio())),
        BlocProvider(
<<<<<<< HEAD
            create: (BuildContext context) =>
                NewsCubitEntertainment(dio: Dio())),
        BlocProvider(
            create: (BuildContext context) => MoreNewsCubit(DioClient())),
=======
            create: (BuildContext context) => NewsTechnologyCubit(dio: Dio())),
>>>>>>> main
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
