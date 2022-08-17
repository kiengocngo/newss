import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news/news_status.dart';
import 'package:news_app/bloc/news_topic/news_state.dart';
import 'package:news_app/dio/config_dio.dart';

class NewsCubitSprots extends Cubit<NewsTopicState> {
  NewsCubitSprots({required this.dio}) : super(const NewsTopicState(error: ''));
  final Dio dio;

  Future<void> getNews() async {
    final base = await DioClient().fetchNewsWithSport();

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
