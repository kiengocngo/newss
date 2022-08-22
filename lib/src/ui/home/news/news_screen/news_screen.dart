import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news/news_page/page_cubit.dart';
import 'package:news_app/theme/news_colors.dart';
import 'package:news_app/theme/news_theme_data.dart';
import 'news_with_page/page.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late PageController _controller;
  List<dynamic> listPage = [
    const Page1(),
    const Page2(),
    const Page3(),
    const Page4(),
    const Page5(),
    const Page6(),
  ];
  final Duration _duration = const Duration(seconds: 2);
  final Curve curve = Curves.ease;
  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
    context.read<Page1Cubit>().getNews();
    context.read<Page2Cubit>().getNews();
    context.read<Page3Cubit>().getNews();
    context.read<Page4Cubit>().getNews();
    context.read<Page5Cubit>().getNews();
    context.read<Page6Cubit>().getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.25,
          automaticallyImplyLeading: false,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                CupertinoIcons.back,
                color: Colors.black,
              )),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 9,
                child: PageView.builder(
                    controller: _controller,
                    itemCount: listPage.length,
                    itemBuilder: (context, index) {
                      return listPage[index];
                    }),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BuildButonNumber(
                        page: 1,
                        onTap: () {
                          _controller.animateToPage(0,
                              duration: _duration, curve: curve);
                        }),
                    const SizedBox(
                      width: 6,
                    ),
                    BuildButonNumber(
                        page: 2,
                        onTap: () {
                          _controller.animateToPage(1,
                              duration: _duration, curve: curve);
                        }),
                    const SizedBox(
                      width: 6,
                    ),
                    BuildButonNumber(
                        page: 3,
                        onTap: () {
                          _controller.animateToPage(2,
                              duration: _duration, curve: curve);
                        }),
                    const SizedBox(
                      width: 6,
                    ),
                    BuildButonNumber(
                        page: 4,
                        onTap: () {
                          _controller.animateToPage(3,
                              duration: _duration, curve: curve);
                        }),
                    const SizedBox(
                      width: 6,
                    ),
                    BuildButonNumber(
                        page: 5,
                        onTap: () {
                          _controller.animateToPage(4,
                              duration: _duration, curve: curve);
                        }),
                    const SizedBox(
                      width: 6,
                    ),
                    BuildButonNumber(
                        page: 6,
                        onTap: () {
                          _controller.animateToPage(5,
                              duration: _duration, curve: curve);
                        }),
                    const SizedBox(
                      width: 6,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class BuildButonNumber extends StatefulWidget {
  final int page;

  final VoidCallback onTap;
  const BuildButonNumber({Key? key, required this.page, required this.onTap})
      : super(key: key);

  @override
  State<BuildButonNumber> createState() => _BuildButonNumberState();
}

class _BuildButonNumberState extends State<BuildButonNumber> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 25,
        width: 25,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 0.5),
          color: NewsColor.bgHotNews,
        ),
        child: Center(
          child: Text(
            widget.page.toString(),
            style: NewsThemeData.fromContext(context).textHotNews,
          ),
        ),
      ),
    );
  }
}
