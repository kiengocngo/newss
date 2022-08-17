
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/components/constant.dart';
import 'package:news_app/src/models/news/results_model.dart';
import 'package:news_app/theme/news_theme_data.dart';

class NewsTopicItems extends StatelessWidget {
  final Results results;
  final VoidCallback onTap;
  const NewsTopicItems({Key? key, required this.results, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: MediaQuery.of(context).size.width * 1 / 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[200],
          ),
          child: Column(
            children: [
              results.imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: results.imageUrl!,
                      height: 100,
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => const Center(
                        child: Icon(Icons.error),
                      ),
                    )
                  : Image.asset(
                      Constant.imageAvaliable,
                      height: 100,
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width,
                    ),
              Flexible(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  results.title,
                  style: NewsThemeData.fromContext(context).textNewsTitle,
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}