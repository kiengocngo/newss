import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news/more_news/more_news_cubit.dart';
import 'package:news_app/bloc/news/more_news/more_news_state.dart';
import 'package:news_app/src/components/loading/bottom_loader.dart';
import 'package:news_app/src/components/loading/center_loader.dart';
import 'package:news_app/src/loaduri/load_url.dart';
import 'package:news_app/src/models/news/results_model.dart';
import 'package:news_app/src/components/news_item/topic_items.dart';

class LoadMoreNews extends StatefulWidget {
  const LoadMoreNews({Key? key}) : super(key: key);

  @override
  State<LoadMoreNews> createState() => _LoadMoreNewsState();
}

class _LoadMoreNewsState extends State<LoadMoreNews> {
  final _scrollController = ScrollController();
  void setupScrollController() {
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0) {
          context.read<MoreNewsCubit>().loadPost();
        }
      }
    });
  }

  Future refresh() async {
    const Duration(seconds: 3);
    setState(() {
      _newsList();
    });
  }

  @override
  void initState() {
    super.initState();
    setupScrollController();
    context.read<MoreNewsCubit>().loadPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0.25,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            CupertinoIcons.back,
            color: Colors.black,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: _newsList(),
      ),
    );
  }

  Widget _newsList() {
    return BlocBuilder<MoreNewsCubit, MoreNewsState>(builder: (context, state) {
      if (state is NewsLoading && state.isFirstFetch) {
        return const CenterLoader();
      }
      List<Results> results = [];
      bool isLoading = false;
      if (state is NewsLoading) {
        results = state.oldNews;
        isLoading = true;
      } else if (state is NewsLoaded) {
        results = state.results;
      }

      return Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: results.length + (isLoading ? 1 : 0),
          itemBuilder: (context, int index) {
            return (index >= results.length)
                ? const BottomLoader()
                : TopicItems(
                    results: results[index],
                    onTap: () {
                      LoadUrl().loadUrl(results[index].link);
                    },
                  );
          },
        ),
      );
    });
  }
}
