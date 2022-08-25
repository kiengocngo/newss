import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/ui/profile_settings/profile_settings_screen.dart';

import '../../../blocs/get_users_bloc/get_users_bloc.dart';
import '../password_change/password_change_screen.dart';

enum Language { english, vietnammese }

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Language? _character = Language.english;
  @override
  void initState() {
    super.initState();
    context
        .read<GetUsersBloc>()
        .add(const GetUsers(uid: 'cZRLuMBnsdRkfPBOaIcKfI8sZBi1'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            tr('Settings'),
            style: const TextStyle(),
          ),
          backgroundColor: Colors.blue,
        ),
        body: BlocBuilder<GetUsersBloc, GetUsersState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            if (state is GetUsersInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetUsersSuccess) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Container(
                  color: Colors.green[200],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: ClipOval(
                          child: SizedBox.fromSize(
                            size: const Size(100, 100), // Image radius
                            child: Image.memory(
                              base64.decode(state.users.base64Image),
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
                          state.users.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30.0),
                        ),
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Container(
                          width: 350,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                              color: Colors.white12),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    tr('PROFILE SETTINGS'),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  trailing:
                                      const Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProfileScreen(
                                                  users: state.users,
                                                )));
                                  },
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  width: double.infinity,
                                  height: 1.0,
                                  color: Colors.grey.shade400,
                                ),
                                ListTile(
                                  title: Text(
                                    tr('LANGUAGE SETTINGS'),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  trailing:
                                      const Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(tr('Change Language')),
                                            actions: [
                                              Column(
                                                children: [
                                                  ListTile(
                                                    title:
                                                        const Text('English'),
                                                    leading: Radio<Language>(
                                                      value: Language.english,
                                                      groupValue: _character,
                                                      onChanged:
                                                          (Language? value) {
                                                        setState(() {
                                                          _character = value;
                                                        });
                                                        context.setLocale(
                                                            const Locale('en'));
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ),
                                                  ListTile(
                                                    title: const Text(
                                                        'Vietnammese'),
                                                    leading: Radio<Language>(
                                                      value:
                                                          Language.vietnammese,
                                                      groupValue: _character,
                                                      onChanged:
                                                          (Language? value) {
                                                        setState(() {
                                                          _character = value;
                                                        });
                                                        context.setLocale(
                                                            const Locale('vi'));
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        });
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const LanguageScreen()));
                                  },
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  width: double.infinity,
                                  height: 1.0,
                                  color: Colors.grey.shade400,
                                ),
                                ListTile(
                                  title: Text(
                                    tr('CHANGE PASSWORD'),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  trailing:
                                      const Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const PasswordScreen()));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Text('Error');
            }
          },
        ));
  }
}
