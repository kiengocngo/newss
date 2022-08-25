import 'package:equatable/equatable.dart';
import 'package:news_app/bloc/news/news_status.dart';
import 'package:news_app/src/models/news/results_model.dart';

class NewsState extends Equatable {
  final NewsStatus status;
  final String error;
  final List<Results> results;
  const NewsState(
      {this.status = NewsStatus.initial,
      this.results = const <Results>[],
      required this.error});

  NewsState copyWith({
    NewsStatus? status,
    String? error,
    List<Results>? results,
  }) {
    return NewsState(
        status: status ?? this.status,
        results: results ?? this.results,
        error: error ?? this.error);
  }

  @override
  List<Object?> get props => [status, results, error];
}
