import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/models/news/results_model.dart';
import 'package:news_app/theme/news_colors.dart';
import 'package:news_app/theme/news_theme_data.dart';

class DetailNewsScreen extends StatefulWidget {
  final Results? results;
  const DetailNewsScreen({Key? key, this.results}) : super(key: key);

  @override
  State<DetailNewsScreen> createState() => _DetailNewsScreenState();
}

class _DetailNewsScreenState extends State<DetailNewsScreen>
    with SingleTickerProviderStateMixin {
  late Animation containerRadiusAnimtaion,
      containerSizeAnimation,
      containerColorAnimation;
  late AnimationController containerAnimationController;

  @override
  void initState() {
    super.initState();
    containerAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    containerRadiusAnimtaion = BorderRadiusTween(
            begin: BorderRadius.circular(0), end: BorderRadius.circular(20))
        .animate(CurvedAnimation(
            parent: containerAnimationController, curve: Curves.ease));
    containerColorAnimation = ColorTween(begin: Colors.grey, end: Colors.white)
        .animate(CurvedAnimation(
            parent: containerAnimationController, curve: Curves.ease));
    containerAnimationController.forward();
    log(widget.results!.category.toString());
  }

  @override
  void dispose() {
    containerAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<dynamic> categories = widget.results!.category;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              CupertinoIcons.back,
              color: Colors.black,
            )),
        backgroundColor: NewsColor.textWhite,
        centerTitle: true,
        title: Text(
          'Detail News',
          style: NewsThemeData.fromContext(context).textAppBar,
        ),
      ),
      body: AnimatedBuilder(
        animation: containerAnimationController,
        builder: (context, index) => SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(color: containerColorAnimation.value),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    widget.results!.title,
                    style: NewsThemeData.fromContext(context).textNewsTitle,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  SizedBox(
                    height: 26,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            width: 6,
                          );
                        },
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return Container(
                              height: 26,
                              decoration: BoxDecoration(
                                  color: NewsColor.bgHotNews,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Center(
                                    child: Text(
                                  categories[index],
                                  style: NewsThemeData.fromContext(context)
                                      .textHotNews,
                                )),
                              ));
                        }),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  widget.results!.pubDate != null
                      ? Text(
                          'Posted: ${widget.results!.pubDate!}',
                          style: NewsThemeData.fromContext(context)
                              .textDescription,
                        )
                      : Container(),
                  const SizedBox(
                    height: 6,
                  ),
                  widget.results!.imageUrl != null
                      ? Image.network(widget.results!.imageUrl!,
                          height: MediaQuery.of(context).size.height * 1 / 3,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill)
                      : Image.asset(
                          'assets/images/image.jpg',
                          height: MediaQuery.of(context).size.height * 1 / 3,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                        ),
                  const SizedBox(
                    height: 6,
                  ),
                  widget.results!.description != null
                      ? Text(
                          widget.results!.description!,
                          style: NewsThemeData.fromContext(context)
                              .textDescription,
                        )
                      : Container(),
                  const SizedBox(
                    height: 12,
                  ),
                  widget.results!.content != null
                      ? Text(
                          widget.results!.content!,
                          style:
                              NewsThemeData.fromContext(context).textNewsTitle,
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
