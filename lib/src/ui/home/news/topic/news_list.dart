import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/bloc.dart';
import 'package:news_app/src/components/components.dart';
import 'package:news_app/src/load_url/load_url.dart';
import 'package:news_app/src/models/model.dart';

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
                      : TopicItems(
                          results: list[index],
                          onTap: () {
                            LoadUrl().loadUrl(list[index].link);
                          },
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
