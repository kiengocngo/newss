import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news/news_status.dart';
import 'package:news_app/bloc/news_topics/news_topics_state.dart';
import 'package:news_app/dio/config_dio.dart';

class NewsTopicsCubit extends Cubit<NewsTopicsState> {
  NewsTopicsCubit({required this.dio})
      : super(const NewsTopicsState(error: ''));
  final Dio dio;

  Future<void> getNews() async {
    final base = await DioClient().fetchNewsForYou();
    if (state.status == NewsStatus.initial) {
      return emit(
          state.copyWith(status: NewsStatus.success, results: base.data));
    }
    return emit(state.copyWith(
      status: NewsStatus.failure,
      error: base.error,
    ));
  }
}