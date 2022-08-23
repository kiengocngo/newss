import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/components/loading/center_loader.dart';
import 'package:news_app/src/models/news/results_model.dart';
import 'package:news_app/theme/news_colors.dart';
import 'package:news_app/theme/news_theme_data.dart';

class TopicItems extends StatelessWidget {
  final Results results;
  final VoidCallback onTap;
  const TopicItems({Key? key, required this.results, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  results.imageUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: CachedNetworkImage(
                            progressIndicatorBuilder: (context, url, progress) {
                              return const CenterLoader();
                            },
                            imageUrl: results.imageUrl!,
                            errorWidget: (context, url, error) => Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: NewsColor.bgTextForm,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.error,
                                ),
                              ),
                            ),
                            height: 50,
                            width: 50,
                            fit: BoxFit.fill,
                          ),
                        )
                      : Container(),
                  const SizedBox(
                    width: 4,
                  ),
                  Flexible(
                    child: Text(
                      results.title,
                      style: NewsThemeData.fromContext(context).textNewsTitle,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              results.pubDate != null
                  ? Text(
                      results.pubDate!,
                      style: NewsThemeData.fromContext(context).textDescription,
                    )
                  : Container(),
              const SizedBox(
                height: 4,
              ),
              Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: NewsColor.bgHotNews),
                  child: Text(results.category[0])),
            ],
          ),
        ),
      ),
    );
  }
}
