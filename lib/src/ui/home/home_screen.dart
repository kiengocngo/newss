<<<<<<< HEAD
=======
import 'package:flutter/cupertino.dart';
>>>>>>> main
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
<<<<<<< HEAD
=======

Widget _buildNewsItem(BuildContext context) {
  return BlocBuilder<NewsCubit, NewsState>(
    builder: (context, state) {
      switch (state.status) {
        case NewsStatus.failure:
          return Text(state.error);
        case NewsStatus.success:
          if (state.results.isEmpty) {
            return const Text('no data');
          }
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) {
              return const SizedBox(
                width: 10,
              );
            },
            itemCount: state.results.length,
            itemBuilder: (context, index) => NewsItems(
                results: state.results[index],
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailNewsScreen(
                                results: state.results[index],
                              )));
                }),
          );
        default:
          return const Center(
            child: CircularProgressIndicator(),
          );
      }
    },
  );
}

Widget _buildNewsItem1(BuildContext context) {
  return BlocBuilder<NewsTopicsCubit, NewsTopicsState>(
    builder: (context, state) {
      switch (state.status) {
        case NewsStatus.failure:
          return Text(state.error);
        case NewsStatus.success:
          if (state.results.isEmpty) {
            return const Text('no data');
          }
          return ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 10,
                );
              },
              itemCount: state.results.length,
              itemBuilder: (context, index) =>
                  NewsTopicItems(results: state.results[index], onTap: () {}));
        default:
          return const Center(
            child: CircularProgressIndicator(),
          );
      }
    },
  );
}
>>>>>>> main
