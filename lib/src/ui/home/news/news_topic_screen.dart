import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news/news_status.dart';
import 'package:news_app/bloc/news_topic/news_cubit_entertainment.dart';
import 'package:news_app/bloc/news_topic/news_cubit_sports.dart';
import 'package:news_app/bloc/news_topic/news_cubit_technology.dart';
import 'package:news_app/bloc/news_topic/news_state.dart';
import 'package:news_app/src/ui/home/news/topic/build_entertainment_screen.dart';
import 'package:news_app/theme/news_colors.dart';
import 'package:news_app/theme/news_theme_data.dart';
import 'topic/build_sports_screen.dart';
import 'topic/build_technology_screen.dart';

class NewsTopicScreen extends StatefulWidget {
  const NewsTopicScreen({Key? key}) : super(key: key);

  @override
  State<NewsTopicScreen> createState() => _NewsTopicScreenState();
}

class _NewsTopicScreenState extends State<NewsTopicScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    context.read<NewsCubitSprots>().getNews();
    context.read<NewsCubitTechnology>().getNews();
    context.read<NewsCubitEntertainment>().getNews();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              CupertinoIcons.back,
              color: NewsColor.searchIcon,
            ),
          ),
          elevation: 0.25,
          backgroundColor: Colors.white,
          title: TabBar(
            unselectedLabelColor: NewsColor.bgTextForm,
            isScrollable: true,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.green),
            tabs: [
              Text(
                'Sports',
                style: NewsThemeData.fromContext(context).textNewsTitle,
              ),
              Text(
                'Technology',
                style: NewsThemeData.fromContext(context).textNewsTitle,
              ),
              Text(
                'Entertainment',
                style: NewsThemeData.fromContext(context).textNewsTitle,
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: const TabBarView(children: [
                  BuildNewsSport(),
                  BuildTechnology(),
                  BuildEntertainment(),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildNewsSports() {
    return BlocBuilder<NewsCubitSprots, NewsTopicState>(
        builder: (context, state) {
      switch (state.status) {
        case NewsStatus.failure:
          return Text(state.error);
        case NewsStatus.success:
          if (state.results.isEmpty) {
            return const Text('no data');
          }
          return ListView.builder(
              itemCount: state.results.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      Text(state.results[index].title),
                    ],
                  ),
                );
              });
        default:
          return const Center(
            child: CircularProgressIndicator(),
          );
      }
    });
  }
}
