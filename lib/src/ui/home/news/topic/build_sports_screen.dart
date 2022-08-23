import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news/news_status.dart';
<<<<<<< HEAD
import 'package:news_app/bloc/news_topic/news_cubit_sports.dart';
import 'package:news_app/bloc/news_topic/news_state.dart';
import 'package:news_app/src/components/loading/center_loader.dart';
import 'package:news_app/src/loaduri/load_url.dart';
import 'package:news_app/src/components/news_item/topic_items.dart';
=======
import 'package:news_app/bloc/news_topic/sport/news_sports_cubit.dart';
import 'package:news_app/bloc/news_topic/sport/news_sports_state.dart';
import 'package:news_app/src/ui/home/news/detail_news_screen.dart';
import 'package:news_app/src/ui/home/news/topic/topic_items.dart';
>>>>>>> main

class BuildNewsSport extends StatefulWidget {
  const BuildNewsSport({Key? key}) : super(key: key);
  @override
  State<BuildNewsSport> createState() => _BuildNewsSportState();
}

class _BuildNewsSportState extends State<BuildNewsSport>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    context.read<NewsSportsCubit>().getNews();
    super.initState();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return BlocBuilder<NewsSportsCubit, NewsSportsState>(
        builder: (context, state) {
      switch (state.status) {
        case NewsStatus.failure:
          return Text(state.error);
        case NewsStatus.success:
          if (state.results.isEmpty) {
            return const Text('no data');
          }
          return ListView.builder(
<<<<<<< HEAD
              itemCount: state.results.length,
              itemBuilder: (context, index) {
                return TopicItems(
                    results: state.results[index],
                    onTap: () {
                      LoadUrl().loadUrl(state.results[index].link);
                    });
              });
        default:
          return const CenterLoader();
=======
            itemCount: state.results.length,
            itemBuilder: (context, index) {
              return TopicItems(
                results: state.results[index],
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailNewsScreen(
                                results: state.results[index],
                              )));
                },
              );
            },
          );
        default:
          return const Center(child: CircularProgressIndicator());
>>>>>>> main
      }
    });
  }
}
