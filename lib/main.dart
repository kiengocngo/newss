import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:news_app/blocs/chats_bloc/chats_bloc.dart';
import 'package:news_app/blocs/conversations_bloc/conversations_bloc.dart';
import 'package:news_app/blocs/friend_request_bloc/friend_request_bloc.dart';
import 'package:news_app/blocs/friend_search_bloc/friend_search_bloc.dart';
import 'package:news_app/blocs/info_changes_bloc/info_changes_bloc.dart';
import 'package:news_app/blocs/log_in_bloc/log_in_bloc.dart';
import 'package:news_app/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:news_app/cubit/image_cubit.dart';
import 'package:news_app/firebase_options.dart';
import 'package:news_app/bloc/bloc.dart';
import 'package:news_app/dio/dio.dart';
import 'package:news_app/blocs/change_password_bloc/change_password_bloc.dart';
import 'package:news_app/blocs/get_users_bloc/get_users_bloc.dart';
import 'package:news_app/blocs/update_users_bloc/update_users_bloc.dart';
import 'app_translations.dart';
import 'blocs/log_in_bloc/log_in_bloc.dart';
import 'src/routes/app_routes.dart';

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
        BlocProvider<FriendSearchBloc>(create: (context) => FriendSearchBloc()),
        BlocProvider<ChatsBloc>(create: (context) => ChatsBloc()),
        BlocProvider<ConversationsBloc>(
            create: (context) => ConversationsBloc()),
        BlocProvider<FriendRequestBloc>(
            create: (context) => FriendRequestBloc()),
        BlocProvider<LogInBloc>(create: (context) => LogInBloc()),
        BlocProvider<SignUpBloc>(create: (context) => SignUpBloc()),
        BlocProvider<ImageCubit>(create: (context) => ImageCubit()),
        BlocProvider<InfoChangesBloc>(create: (context) => InfoChangesBloc()),
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
        BlocProvider(create: (context) => ImageCubit()),
        BlocProvider(create: (context) => UpdateUsersBloc()),
        BlocProvider(create: (context) => GetUserBloc()),
        BlocProvider(create: (context) => ChangePasswordBloc()),
        BlocProvider(
            create: (BuildContext context) =>
                LoadMoreBloc(dioClient: DioClient())),
      ],
      child: GetMaterialApp(
        theme: ThemeData(),
        initialRoute: '/bottom',
        routes: AppRoutes.routes,
        debugShowCheckedModeBanner: false,
        translations: AppTranslation(),
        locale: Get.deviceLocale,
      ),
    );
  }
}
