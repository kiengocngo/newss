import 'package:news_app/src/models/news/results_model.dart';

abstract class MoreNewsState {}

class NewsInitial extends MoreNewsState {}

class NewsLoaded extends MoreNewsState {
  final List<Results> results;
  NewsLoaded(this.results);
}

class NewsLoading extends MoreNewsState {
  final bool isFirstFetch;
  final List<Results> oldNews;
  NewsLoading(this.oldNews, {this.isFirstFetch = false});
}

class EndNews extends MoreNewsState {
  final List<Results> endList;
  final String noti;
  EndNews(this.noti, this.endList);
}
