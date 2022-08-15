import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news/news_cubit.dart';
import 'package:news_app/bloc/news/news_state.dart';
import 'package:news_app/bloc/news/news_status.dart';
import 'package:news_app/theme/news_colors.dart';
import 'package:news_app/theme/news_theme_data.dart';

import 'news/detail_news_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    context.read<NewsCubit>().getNews();
    _tabController = TabController(length: 11, vsync: this);
  }

  Future refresh() async {
    context.read<NewsCubit>().getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: NewsColor.textWhite,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '#Hot News',
                style: NewsThemeData.fromContext(context).textAppBar,
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(flex: 1, child: _buildNewsItem(context)),
              const SizedBox(
                height: 10,
              ),
              Text(
                '#News - Topic',
                style: NewsThemeData.fromContext(context).textAppBar,
              ),
              Expanded(
                flex: 2,
                child: Container(),
                //tabbar -topic
                // Column(
                //   children: [
                //     Container(
                //       color: Colors.grey,
                //       height: 30,
                //       width: MediaQuery.of(context).size.width,
                //       child: Expanded(
                //         child: TabBar(
                //           isScrollable: true,
                //           controller: _tabController,
                //           tabs: const [
                //             Text('1'),
                //             Text('2'),
                //             Text('3'),
                //             Text('4'),
                //             Text('5'),
                //             Text('6'),
                //             Text('7'),
                //             Text('8'),
                //             Text('9'),
                //             Text('10'),
                //             Text('11'),
                //           ],
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       height: MediaQuery.of(context).size.height * 1 / 2 - 30,
                //       child: TabBarView(
                //           controller: _tabController,
                //           children: const [
                //             Text('Business'),
                //             Text('Entertainment'),
                //             Text('Environment'),
                //             Text('Food'),
                //             Text('Health'),
                //             Text('Politics'),
                //             Text('Science'),
                //             Text('Sport'),
                //             Text('Technology'),
                //             Text('Top'),
                //             Text('Word'),
                //           ]),
                //     ),
                //   ],
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildNewsItem(BuildContext context) {
  return BlocBuilder<NewsCubit, NewsState>(
    builder: (context, state) {
      switch (state.status) {
        case NewsStatus.failure:
          return Text(state.error);
        case NewsStatus.success:
          if (state.results.isEmpty) {
            return const Text('no data');
          }
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) {
              return const SizedBox(
                width: 10,
              );
            },
            itemCount: state.results.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailNewsScreen(
                              results: state.results[index],
                            )));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 1 / 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[200],
                    ),
                    child: Column(
                      children: [
                        state.results[index].imageUrl != null
                            ? Image.network(
                                state.results[index].imageUrl!,
                                height: 100,
                                fit: BoxFit.fill,
                                width: MediaQuery.of(context).size.width,
                              )
                            : Image.asset(
                                'assets/images/image.jpg',
                                height: 100,
                                fit: BoxFit.fill,
                                width: MediaQuery.of(context).size.width,
                              ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              state.results[index].title,
                              style: NewsThemeData.fromContext(context)
                                  .textNewsTitle,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: Container(
                      height: 30,
                      width: 50,
                      color: NewsColor.bgHotNews,
                      child: Center(
                        child: Text(
                          'Hot',
                          style: NewsThemeData.fromContext(context).textHotNews,
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          );
        default:
          return const Center(
            child: CircularProgressIndicator(),
          );
      }
    },
  );
}
