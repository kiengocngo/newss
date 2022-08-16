import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news/news_cubit.dart';
import 'package:news_app/bloc/news/news_state.dart';
import 'package:news_app/bloc/news/news_status.dart';
import 'package:news_app/bloc/news_topics/news_topics_cubit.dart';
import 'package:news_app/bloc/news_topics/news_topics_state.dart';
import 'package:news_app/src/components/news_item/news_items.dart';
import 'package:news_app/src/components/news_item/news_topic_items.dart';
import 'package:news_app/theme/news_colors.dart';
import 'package:news_app/theme/news_theme_data.dart';
import 'news/detail_news_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NewsCubit>().getNews();
    context.read<NewsTopicsCubit>().getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: NewsColor.textWhite,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '#Hot News',
                style: NewsThemeData.fromContext(context).textAppBar,
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(flex: 1, child: _buildNewsItem(context)),
              const SizedBox(
                height: 10,
              ),
              Text(
                '#News - For you',
                style: NewsThemeData.fromContext(context).textAppBar,
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                flex: 1,
                child: _buildNewsItem1(context),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '#News - Topics',
                style: NewsThemeData.fromContext(context).textAppBar,
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(flex: 1, child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}

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
              itemBuilder: (context, index) => NewsTopicItems(
                  results: state.results[index],
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailNewsScreen(
                                results: state.results[index])));
                  }));
        default:
          return const Center(
            child: CircularProgressIndicator(),
          );
      }
    },
  );
}
