import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news/news_status.dart';
import 'package:news_app/bloc/news_topic/news_cubit_technology.dart';
import 'package:news_app/bloc/news_topic/news_state.dart';
import 'package:news_app/src/components/loading/center_loader.dart';
import 'package:news_app/src/loaduri/load_url.dart';
import 'package:news_app/src/components/news_item/topic_items.dart';

class BuildTechnology extends StatefulWidget {
  const BuildTechnology({Key? key}) : super(key: key);

  @override
  State<BuildTechnology> createState() => _BuildNewsTechnologyState();
}

class _BuildNewsTechnologyState extends State<BuildTechnology> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubitTechnology, NewsTopicState>(
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
