import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/ui/home/news/topic/build_entertainment_screen.dart';
import 'package:news_app/theme/news_colors.dart';
import 'package:news_app/theme/news_theme_data.dart';
import 'topic/build_sports_screen.dart';
import 'topic/build_technology_screen.dart';

class NewsTopicScreen extends StatefulWidget {
  const NewsTopicScreen({Key? key}) : super(key: key);

  @override
  State<NewsTopicScreen> createState() => _NewsTopicScreenState();
}

class _NewsTopicScreenState extends State<NewsTopicScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              CupertinoIcons.back,
              color: NewsColor.searchIcon,
            ),
          ),
          elevation: 0.25,
          backgroundColor: Colors.white,
          title: TabBar(
            unselectedLabelColor: NewsColor.bgTextForm,
            controller: tabController,
            isScrollable: true,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.green),
            tabs: [
              Text(
                'Sports',
                style: NewsThemeData.fromContext(context).textNewsTitle,
              ),
              Text(
                'Technology',
                style: NewsThemeData.fromContext(context).textNewsTitle,
              ),
              Text(
                'Entertainment',
                style: NewsThemeData.fromContext(context).textNewsTitle,
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: TabBarView(
                  controller: tabController,
                  children: const [
                    BuildNewsSport(),
                    BuildTechnology(),
                    BuildEntertainment(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
