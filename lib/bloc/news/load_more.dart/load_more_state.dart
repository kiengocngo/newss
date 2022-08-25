import 'package:equatable/equatable.dart';
import 'package:news_app/src/models/news/results_model.dart';

enum LoadMoreStatus { initial, success, failure, end }

class LoadMoreState extends Equatable {
  final LoadMoreStatus status;
  final List<Results> results;
  final bool hasReachedMax;

  const LoadMoreState({
    this.status = LoadMoreStatus.initial,
    this.results = const <Results>[],
    this.hasReachedMax = false,
  });

  const LoadMoreState.initial() : this();
  const LoadMoreState.success(
      List<Results> results, hasReachedMax, LoadMoreStatus status)
      : this(results: results, hasReachedMax: hasReachedMax, status: status);
  const LoadMoreState.failure(hasReachedMax, LoadMoreStatus status)
      : this(hasReachedMax: hasReachedMax, status: status);
  const LoadMoreState.end(
      hasReachedMax, LoadMoreStatus status, List<Results> results)
      : this(hasReachedMax: hasReachedMax, status: status, results: results);

  @override
  List<Object?> get props => [status, results, hasReachedMax];
}
