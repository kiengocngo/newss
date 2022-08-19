import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news/news_status.dart';
import 'package:news_app/bloc/news_topic/technology/new_technology_state.dart';
import 'package:news_app/bloc/news_topic/technology/news_technology_cubit.dart';
import 'package:news_app/src/ui/home/news/detail_news_screen.dart';
import 'package:news_app/src/ui/home/news/topic/topic_items.dart';

class BuildTechnology extends StatefulWidget {
  const BuildTechnology({Key? key}) : super(key: key);

  @override
  State<BuildTechnology> createState() => _BuildTechnologyState();
}

class _BuildTechnologyState extends State<BuildTechnology>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    context.read<NewsTechnologyCubit>().getNews();
    super.initState();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return BlocBuilder<NewsTechnologyCubit, NewsTechnologyState>(
        builder: (context, state) {
      switch (state.status) {
        case NewsStatus.failure:
          return Center(
            child: Text(state.error),
          );
        case NewsStatus.success:
          return ListView.builder(
              itemCount: state.results.length,
              itemBuilder: (context, index) {
                return TopicItems(
                    results: state.results[index],
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (contex) => DetailNewsScreen(
                                    results: state.results[index],
                                  )));
                    });
              });
        default:
          return const Center(
            child: CircularProgressIndicator(),
          );
      }
    });
  }
}
