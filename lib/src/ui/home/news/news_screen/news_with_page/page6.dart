import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news/news_page/page5_cubit.dart';
import 'package:news_app/bloc/news/news_state.dart';
import 'package:news_app/bloc/news/news_status.dart';
import 'package:news_app/src/ui/home/news/detail_news_screen.dart';
import 'package:news_app/src/ui/home/news/topic/topic_items.dart';

class Page6 extends StatefulWidget {
  const Page6({Key? key}) : super(key: key);

  @override
  State<Page6> createState() => _Page6State();
}

class _Page6State extends State<Page6> {
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
