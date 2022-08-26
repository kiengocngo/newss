import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/bloc.dart';
import 'package:news_app/dio/dio.dart';
import 'package:news_app/src/routes/app_routes.dart';

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
            create: (BuildContext context) => NewsTopicsBloc(dio: Dio())),
        BlocProvider(
            create: (BuildContext context) => NewsSportsCubit(dio: Dio())),
        BlocProvider(
            create: (BuildContext context) =>
                NewsEntertainmentCubit(dio: Dio())),
        BlocProvider(
            create: (BuildContext context) => NewsTechnologyCubit(dio: Dio())),
        BlocProvider(
            create: (BuildContext context) =>
                LoadMoreBloc(dioClient: DioClient())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        initialRoute: '/home',
        routes: AppRoutes.routes,
      ),
    );
  }
}
