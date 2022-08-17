import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news/news_status.dart';
import 'package:news_app/bloc/news_topic/news_state.dart';
import 'package:news_app/dio/config_dio.dart';

class NewsCubitEntertainment extends Cubit<NewsTopicState> {
  NewsCubitEntertainment({required this.dio})
      : super(const NewsTopicState(error: ''));
  final Dio dio;

  Future<void> getNews() async {
    final base = await DioClient().fetchNewsEntertainment();

    if (state.status == NewsStatus.initial ||
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
