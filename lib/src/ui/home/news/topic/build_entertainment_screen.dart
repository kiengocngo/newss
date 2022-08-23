import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news/news_status.dart';
<<<<<<< HEAD
import 'package:news_app/bloc/news_topic/news_cubit_entertainment.dart';
import 'package:news_app/bloc/news_topic/news_state.dart';
import 'package:news_app/src/components/loading/center_loader.dart';
import 'package:news_app/src/loaduri/load_url.dart';
import 'package:news_app/src/components/news_item/topic_items.dart';
=======
import 'package:news_app/bloc/news_topic/entertainment/news_enteratainment_cubit.dart';
import 'package:news_app/bloc/news_topic/entertainment/news_entertainment_state.dart';
import 'package:news_app/src/ui/home/news/detail_news_screen.dart';
import 'package:news_app/src/ui/home/news/topic/topic_items.dart';
>>>>>>> main

class BuildEntertainment extends StatefulWidget {
  const BuildEntertainment({Key? key}) : super(key: key);

  @override
  State<BuildEntertainment> createState() => _BuildEntertainmentState();
}

class _BuildEntertainmentState extends State<BuildEntertainment>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    context.read<NewsEntertainmentCubit>().getNews();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return BlocBuilder<NewsEntertainmentCubit, NewsEntertainmentState>(
        builder: (context, state) {
      switch (state.status) {
        case NewsStatus.failure:
          return Center(
            child: Text(state.error),
          );
        case NewsStatus.success:
          if (state.results.isEmpty) {
            return const Center(
              child: Text('no data'),
            );
          }
          return ListView.builder(
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
      }
    });
  }
}
