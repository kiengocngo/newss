import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:news_app/blocs/get_users_bloc/get_users_bloc.dart';
import 'package:news_app/blocs/log_in_bloc/log_in_bloc.dart';
import 'package:news_app/src/ui/password_change/password_change_screen.dart';
import 'package:news_app/src/ui/profile_settings/profile_settings_screen.dart';
import 'package:news_app/theme/news_theme_data.dart';

enum Language { english, vietnammese }

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  Language character = Language.english;
  SettingsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    context
        .read<GetUserBloc>()
        .add(GetUsers(uid: context.read<LogInBloc>().state.message));
    log(context.read<LogInBloc>().state.message);

    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0.25,
          centerTitle: true,
          title: Text(
            'settings'.tr,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        body: BlocBuilder<GetUserBloc, GetUserState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            switch (state.getStatus) {
              case GetStatus.init:
                return const Center(child: CircularProgressIndicator());
              case GetStatus.success:
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: ClipOval(
                          child: SizedBox.fromSize(
                            size: const Size(100, 100), // Image radius
                            child: Image.memory(
                              base64.decode(state.user.base64Image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          state.user.name,
                          style: NewsThemeData.fromContext(context).textSetting,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            color: Colors.white12),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                'profile'.tr,
                                style: NewsThemeData.fromContext(context)
                                    .textSetting,
                              ),
                              trailing: const Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProfileScreen(
                                              users: state.user,
                                            )));
                              },
                            ),
                            const Divider(),
                            ListTile(
                              title: Text(
                                'language'.tr,
                                style: NewsThemeData.fromContext(context)
                                    .textSetting,
                              ),
                              trailing: const Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('language'.tr),
                                        actions: [
                                          Column(
                                            children: [
                                              ListTile(
                                                title: const Text('English'),
                                                leading: Radio<Language>(
                                                  value: Language.english,
                                                  groupValue: character,
                                                  onChanged: (Language? value) {
                                                    Get.updateLocale(
                                                        const Locale(
                                                            'en', 'US'));
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),
                                              ListTile(
                                                title:
                                                    const Text('Vietnammese'),
                                                leading: Radio<Language>(
                                                  value: Language.vietnammese,
                                                  groupValue: character,
                                                  onChanged: (Language? value) {
                                                    Get.updateLocale(
                                                        const Locale(
                                                            'vi', 'VN'));
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    });
                              },
                            ),
                            const Divider(),
                            ListTile(
                              title: Text(
                                'change_pass'.tr,
                                style: NewsThemeData.fromContext(context)
                                    .textSetting,
                              ),
                              trailing: const Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PasswordScreen()));
                              },
                            ),
                            BlocListener<LogInBloc, LogInState>(
                              listener: (context, state) {
                                if (state.logInStatus == LogInStatus.init) {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      "/login",
                                      (Route<dynamic> route) => false);
                                }
                              },
                              child: ListTile(
                                title: Text(
                                  'log_out'.tr,
                                  style: NewsThemeData.fromContext(context)
                                      .textSetting,
                                ),
                                trailing:
                                    const Icon(Icons.keyboard_arrow_right),
                                onTap: () {
                                  context
                                      .read<LogInBloc>()
                                      .add(const LogInSignOutEvent());
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              default:
                return Text(state.message);
            }
          },
        ));
  }
}
