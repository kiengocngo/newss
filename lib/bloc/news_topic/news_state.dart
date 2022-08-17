import 'package:equatable/equatable.dart';
import 'package:news_app/bloc/news/news_status.dart';
import 'package:news_app/src/models/news/results_model.dart';

class NewsTopicState extends Equatable {
  final NewsStatus status;
  final String error;
  final List<Results> results;
  const NewsTopicState(
      {this.status = NewsStatus.initial,
      this.results = const <Results>[],
      required this.error});

  NewsTopicState copyWith({
    NewsStatus? status,
    String? error,
    List<Results>? results,
  }) {
    return NewsTopicState(
        status: status ?? this.status,
        results: results ?? this.results,
        error: error ?? this.error);
  }

  @override
  List<Object?> get props => [status, results, error];
}
