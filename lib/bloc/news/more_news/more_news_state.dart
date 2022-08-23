import 'package:news_app/src/models/news/results_model.dart';

abstract class MoreNewsState {}

class NewsInitial extends MoreNewsState {}

class NewsLoaded extends MoreNewsState {
  final List<Results> results;
  NewsLoaded(this.results);
}

class NewsLoading extends MoreNewsState {
  final List<Results> oldNews;
  final bool isFirstFetch;
  NewsLoading(this.oldNews, {this.isFirstFetch = false});
}
