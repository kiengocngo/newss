import 'package:equatable/equatable.dart';
import 'package:news_app/bloc/news/news_status.dart';
import 'package:news_app/src/models/news/results_model.dart';

class NewsState extends Equatable {
  final NewsStatus status;
  final String? error;
  final List<Results> results;
  const NewsState(
      {this.status = NewsStatus.initial,
      this.results = const <Results>[],
      this.error});
  const NewsState.initial() : this();
  const NewsState.success(List<Results> results)
      : this(results: results, status: NewsStatus.success);
  const NewsState.failure(String err)
      : this(error: err, status: NewsStatus.failure);

  @override
  List<Object?> get props => [status, results, error];
}
