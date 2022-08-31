import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/bloc.dart';
import 'package:news_app/src/components/components.dart';
import 'package:news_app/src/load_url/load_url.dart';

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
          return Text(state.error!);
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
