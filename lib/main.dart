import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news/news_cubit.dart';
import 'package:news_app/bloc/news_topics/news_topics_cubit.dart';
import 'package:news_app/src/routes/app_routes.dart';

import 'package:news_app/src/ui/splash/splash_screen.dart';

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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        initialRoute: '/splash',
        
        routes: AppRoutes.routes
         
        ,
      ),
    );
  }
}
