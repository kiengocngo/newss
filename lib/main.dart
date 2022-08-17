import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/blocs/info_changes_bloc/info_changes_bloc.dart';
import 'package:news_app/blocs/log_in_bloc/log_in_bloc.dart';
import 'package:news_app/cubit/image_cubit.dart';
import 'package:news_app/src/routes/app_routes.dart';
import 'blocs/sign_up_bloc/sign_up_bloc.dart';
import 'firebase_options.dart';

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
        BlocProvider<ImageCubit>(create: (context)=>ImageCubit()),
        BlocProvider<InfoChangesBloc>(
          create: (context) => InfoChangesBloc()
          ),
        BlocProvider<SignUpBloc>(
          create: (context) => SignUpBloc(),
        ),
        BlocProvider<LogInBloc>(
          create: (context) => LogInBloc(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(),
        initialRoute: '/sign_up',
        routes: AppRoutes.routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
