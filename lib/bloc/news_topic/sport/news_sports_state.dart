import 'package:equatable/equatable.dart';
import 'package:news_app/bloc/news/news_status.dart';
import 'package:news_app/src/models/news/results_model.dart';

class NewsSportsState extends Equatable {
  final NewsStatus status;
  final String error;
  final List<Results> results;

  const NewsSportsState({
    this.status = NewsStatus.initial,
    this.results = const <Results>[],
    required this.error,
  });

  NewsSportsState copyWith({
    NewsStatus? status,
    String? error,
    List<Results>? results,
  }) {
    return NewsSportsState(
        status: status ?? this.status,
        results: results ?? this.results,
        error: error ?? this.error);
  }

  @override
  List<Object?> get props => [
        status,
        results,
        error,
      ];
}
