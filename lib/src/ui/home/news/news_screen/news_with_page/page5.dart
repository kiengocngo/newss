import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news/news_page/page_cubit.dart';
import 'package:news_app/bloc/news/news_state.dart';
import 'package:news_app/bloc/news/news_status.dart';
import 'package:news_app/src/ui/home/news/detail_news_screen.dart';
import 'package:news_app/src/ui/home/news/topic/topic_items.dart';

class Page5 extends StatelessWidget {
  const Page5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Page5Cubit, NewsState>(builder: (context, state) {
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailNewsScreen(
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
