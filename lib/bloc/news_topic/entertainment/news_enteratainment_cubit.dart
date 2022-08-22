import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news/news_status.dart';
import 'package:news_app/bloc/news_topic/entertainment/news_entertainment_state.dart';
import 'package:news_app/dio/config_dio.dart';

class NewsEntertainmentCubit extends Cubit<NewsEntertainmentState> {
  NewsEntertainmentCubit({required this.dio})
      : super(const NewsEntertainmentState(error: ''));

  final Dio dio;
  Future<void> getNews() async {
    final base = await DioClient().fetchNewsWithTopics('entertainment');

    if (state.status == NewsStatus.loading ||
        state.status == NewsStatus.success) {
      return emit(
          state.copyWith(status: NewsStatus.success, results: base.data));
    }

    return emit(state.copyWith(
      status: NewsStatus.failure,
      error: base.error,
    ));
  }
}
