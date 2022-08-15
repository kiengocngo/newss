import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
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
          title: const Text('Language Settings'),
          backgroundColor: Colors.blue[700],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Column(children: [
            Text(
              "LANGUAGE",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Choose Language',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                DropdownButton(
                  value: dropdownValue,
                  items: <String>[
                    'English',
                    'Vietnammese',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                    prefs.setString(languageKey, dropdownValue);
                  },
                ),
              ],
            )
          ]),
        ));
  }
}
