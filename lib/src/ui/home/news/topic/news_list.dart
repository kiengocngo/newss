import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news/load_more.dart/load_more_bloc.dart';
import 'package:news_app/bloc/news/load_more.dart/load_more_event.dart';
import 'package:news_app/bloc/news/load_more.dart/load_more_state.dart';
import 'package:news_app/src/components/loading/bottom_loader.dart';
import 'package:news_app/src/components/news_item/topic_items.dart';
import 'package:news_app/src/loaduri/load_url.dart';
import 'package:news_app/src/models/news/results_model.dart';

class NewsList extends StatefulWidget {
  const NewsList({super.key});

  @override
  State<NewsList> createState() => _NewssListState();
}

class _NewssListState extends State<NewsList> {
  final _scrollController = ScrollController();
  List<Results> list = [];
  void setupScrollController() {
    _scrollController.addListener(() {
      final position = _scrollController.position;
      if (position.atEdge && position.pixels != 0) {
        context.read<LoadMoreBloc>().add(NewsFetched());
      }
    });
  }

  Future refresh() async {
    list.clear();
    context.read<LoadMoreBloc>().add(NewsFetched());
  }

  @override
  void initState() {
    super.initState();
    setupScrollController();
    context.read<LoadMoreBloc>().add(NewsFetched());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refresh,
      child: BlocBuilder<LoadMoreBloc, LoadMoreState>(
        builder: (context, state) {
          list = state.results;
          switch (state.status) {
            case LoadMoreStatus.failure:
              return const Center(child: Text('faild to fetch data'));
            case LoadMoreStatus.end:
            case LoadMoreStatus.success:
              if (list.isEmpty) {
                return const Center(child: Text('no news'));
              }
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return index >= list.length
                      ? const BottomLoader()
                      : Column(
                          children: [
                            Text(list.length.toString()),
                            TopicItems(
                              results: list[index],
                              onTap: () {
                                LoadUrl().loadUrl(list[index].link);
                              },
                            ),
                          ],
                        );
                },
                itemCount: state.hasReachedMax ? list.length : list.length + 1,
                controller: _scrollController,
              );
            case LoadMoreStatus.initial:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
