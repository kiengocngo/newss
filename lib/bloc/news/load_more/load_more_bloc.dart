import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/bloc.dart';
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
        page++;
        results.addAll(value);
        emit(LoadMoreState.success(results, false, LoadMoreStatus.success));
      });
    } catch (_) {
      emit(const LoadMoreState.failure(true, LoadMoreStatus.failure));
    }
  }
}
