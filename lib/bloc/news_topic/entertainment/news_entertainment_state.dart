import 'package:equatable/equatable.dart';
import 'package:news_app/bloc/news/news_status.dart';
import 'package:news_app/src/models/news/results_model.dart';

class NewsEntertainmentState extends Equatable {
  final NewsStatus status;
  final String? error;
  final List<Results> results;

  const NewsEntertainmentState({
    this.status = NewsStatus.initial,
    this.results = const <Results>[],
    this.error,
  });
  const NewsEntertainmentState.initial() : this();
  const NewsEntertainmentState.success(List<Results> results,)
      : this(results: results, status: NewsStatus.success);
  const NewsEntertainmentState.failure(String err) : this(error: err, status: NewsStatus.failure);
  @override
  List<Object?> get props => [
        status,
        results,
        error,
      ];
}
