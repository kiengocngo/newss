import 'package:equatable/equatable.dart';
import 'package:news_app/bloc/news/news_status.dart';
import 'package:news_app/src/models/news/results_model.dart';

class NewsTopicsState extends Equatable {
  final NewsStatus status;
  final String? error;
  final List<Results> results;
  const NewsTopicsState(
      {this.status = NewsStatus.initial,
      this.results = const <Results>[],
      this.error});

  const NewsTopicsState.initial() : this();
  const NewsTopicsState.success(
    List<Results> results,
  ) : this(results: results, status: NewsStatus.success);
  const NewsTopicsState.failure(String error)
      : this(status: NewsStatus.failure, error: error);

  @override
  List<Object?> get props => [status, results, error];
}
