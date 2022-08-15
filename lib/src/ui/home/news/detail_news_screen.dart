import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/models/news/results_model.dart';
import 'package:news_app/theme/news_colors.dart';
import 'package:news_app/theme/news_theme_data.dart';

class DetailNewsScreen extends StatefulWidget {
  final Results results;
  const DetailNewsScreen({Key? key, required this.results}) : super(key: key);

  @override
  State<DetailNewsScreen> createState() => _DetailNewsScreenState();
}

class _DetailNewsScreenState extends State<DetailNewsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<dynamic> categories = widget.results.category;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 12,
              ),
              Text(
                widget.results.title,
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
              widget.results.pubDate != null
                  ? Text(
                      'Posted: ${widget.results.pubDate!}',
                      style: NewsThemeData.fromContext(context).textDescription,
                    )
                  : Container(),
              const SizedBox(
                height: 6,
              ),
              widget.results.imageUrl != null
                  ? Image.network(widget.results.imageUrl!,
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
              widget.results.description != null
                  ? Text(
                      widget.results.description!,
                      style: NewsThemeData.fromContext(context).textDescription,
                    )
                  : Container(),
              const SizedBox(
                height: 12,
              ),
              widget.results.content != null
                  ? Text(
                      widget.results.content!,
                      style: NewsThemeData.fromContext(context).textNewsTitle,
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
