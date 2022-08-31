import 'package:flutter/material.dart';
import 'package:news_app/src/ui/settings/settings_screen.dart';
import 'package:news_app/theme/news_colors.dart';
import 'package:news_app/theme/news_theme_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
            icon: const Icon(
              Icons.settings,
              color: Colors.black,
            ),
          )
        ],
        elevation: 0,
        backgroundColor: NewsColor.textWhite,
        centerTitle: true,
        title: Text(
          'HOME',
          style: NewsThemeData.fromContext(context).textAppBar,
        ),
      ),
    );
  }
}
