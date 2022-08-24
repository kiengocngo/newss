import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/blocs/chats_bloc/chats_bloc.dart';
import 'package:news_app/blocs/conversations_bloc/conversations_bloc.dart';
import 'package:news_app/blocs/friend_request_bloc/friend_request_bloc.dart';
import 'package:news_app/blocs/friend_search_bloc/friend_search_bloc.dart';
import 'package:news_app/firebase_options.dart';
import 'package:news_app/src/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
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
      ],
      child: MaterialApp(
        theme: ThemeData(),
        initialRoute: '/enter_chat_room',
        routes: AppRoutes.routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
