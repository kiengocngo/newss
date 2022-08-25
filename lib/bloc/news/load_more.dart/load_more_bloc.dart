import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news/load_more.dart/load_more_event.dart';
import 'package:news_app/bloc/news/load_more.dart/load_more_state.dart';
import 'package:news_app/bloc/news/news_status.dart';
import 'package:news_app/dio/config_dio.dart';

class LoadMoreBloc extends Bloc<LoadMoreEvent, LoadMoreState> {
  LoadMoreBloc({required this.dioClient})
      : super(const LoadMoreState.initial()) {
    on<NewsFetched>(_onNewsFetched);
  }
  final DioClient dioClient;

  int page = 0;
  Future<void> _onNewsFetched(
      NewsFetched event, Emitter<LoadMoreState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == NewsStatus.initial) {
        final results = await dioClient.fetchNewsPage(page);
        emit(LoadMoreState.success(results, false, LoadMoreStatus.success));
      }
      await dioClient.fetchNewsPage(page).then((value) {
        final results = List.of(state.results);
        // if (page < 4) {
        page++;
        log('Page: $page');
        results.addAll(value);
        emit(LoadMoreState.success(results, false, LoadMoreStatus.success));
        // } else {
        //   emit(
        //     LoadMoreState.end(true, LoadMoreStatus.end, results),
        //   );
        // }
      });
    } catch (_) {
      emit(const LoadMoreState.failure(true, LoadMoreStatus.failure));
    }
  }
}
