import 'package:flutter/material.dart';
import 'package:news_app/theme/news_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  CrossFadeState crossFadeState = CrossFadeState.showFirst;
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        crossFadeState = CrossFadeState.showSecond;
      });
    });
    tabController = TabController(length: 11, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.25,
        backgroundColor: Colors.white,
      ),
      body: AnimatedCrossFade(
        duration: const Duration(seconds: 2),
        crossFadeState: crossFadeState,
        firstChild: const Center(
          child: Icon(
            Icons.ac_unit,
            color: Colors.red,
            size: 50,
          ),
        ),
        secondChild: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: NewsColor.bgTextForm,
                ),
                child: TabBar(
                  controller: tabController,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  labelPadding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                  isScrollable: true,
                  tabs: const [
                    Text('Sports'),
                    Text('Technology'),
                    Text('Top'),
                    Text('World'),
                    Text('Science'),
                    Text('Politics'),
                    Text('Health'),
                    Text('Food'),
                    Text('Environment'),
                    Text('Entertainment'),
                    Text('Bussinees'),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: TabBarView(controller: tabController, children: [
                  Container(
                    child: Center(
                      child: Text(tabController.index.toString(), ),
                    ),
                  ),
                  Container(
                    color: Colors.green,
                    height: MediaQuery.of(context).size.height,
                  ),
                  Container(
                    color: Colors.amber,
                    height: MediaQuery.of(context).size.height,
                  ),
                  Container(
                    color: Colors.red,
                  ),
                  Container(
                    color: Colors.green,
                    height: MediaQuery.of(context).size.height,
                  ),
                  Container(
                    color: Colors.amber,
                    height: MediaQuery.of(context).size.height,
                  ),
                  Container(
                    color: Colors.red,
                  ),
                  Container(
                    color: Colors.green,
                    height: MediaQuery.of(context).size.height,
                  ),
                  Container(
                    color: Colors.amber,
                    height: MediaQuery.of(context).size.height,
                  ),
                  Container(
                    color: Colors.red,
                  ),
                  Container(
                    color: Colors.green,
                    height: MediaQuery.of(context).size.height,
                  ),
                ]),
              ),
            ],
          ),
        ),
        firstCurve: Curves.bounceIn,
        secondCurve: Curves.easeInBack,
      ),
    );
  }
}
