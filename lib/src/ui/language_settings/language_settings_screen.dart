import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Language { english, vietnammese }

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  Language? _character = Language.english;
  String dropdownValue = 'English';
  late SharedPreferences prefs;
  final languageKey = 'language';

  getLanguage() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      final languageValue = prefs.getString(languageKey);
      if (languageValue != null) {
        dropdownValue = languageValue;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getLanguage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(tr('Language Settings')),
          backgroundColor: Colors.blue[700],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Column(
            children: <Widget>[
              Text(
                tr('Choose Language'),
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700]),
              ),
              const SizedBox(
                height: 15,
              ),
              ListTile(
                title: const Text('English'),
                leading: Radio<Language>(
                  value: Language.english,
                  groupValue: _character,
                  onChanged: (Language? value) {
                    setState(() {
                      _character = value;
                    });
                    context.setLocale(const Locale('en'));
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
                    context.setLocale(const Locale('vi'));
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
