import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/ui/profile_settings/profile_settings_screen.dart';
import 'package:news_app/theme/news_colors.dart';
import 'package:news_app/theme/news_theme_data.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            tr('Settings'),
            style: const TextStyle(color: Colors.black),
          ),
          elevation: 0.5,
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Image.network(
                    'https://thumbs.dreamstime.com/b/businessman-icon-image-male-avatar-profile-vector-glasses-beard-hairstyle-179728610.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              const Center(
                child: Text(
                  'N.Q.Tu',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Divider(),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          tr('PROFILE SETTINGS'),
                          style:
                              NewsThemeData.fromContext(context).textSettings,
                        ),
                        trailing: const Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProfileScreen()));
                        },
                      ),
                      const Divider(
                        color: NewsColor.newsGrey,
                      ),
                      ListTile(
                        title: Text(
                          tr('LANGUAGE SETTINGS'),
                          style:
                              NewsThemeData.fromContext(context).textSettings,
                        ),
                        trailing: const Icon(Icons.keyboard_arrow_right),
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
                                          title: const Text('English'),
                                          leading: Radio<Language>(
                                            value: Language.english,
                                            groupValue: _character,
                                            onChanged: (Language? value) {
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
                                          title: const Text('Vietnammese'),
                                          leading: Radio<Language>(
                                            value: Language.vietnammese,
                                            groupValue: _character,
                                            onChanged: (Language? value) {
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
                      const Divider(
                        color: NewsColor.newsGrey,
                      ),
                      ListTile(
                        title: Text(
                          tr('CHANGE PASSWORD'),
                          style:
                              NewsThemeData.fromContext(context).textSettings,
                        ),
                        trailing: const Icon(Icons.keyboard_arrow_right),
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
            ],
          ),
        ));
  }
}
