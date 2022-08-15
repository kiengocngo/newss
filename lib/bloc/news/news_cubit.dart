import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news/news_state.dart';
import 'package:news_app/bloc/news/news_status.dart';
import 'package:news_app/dio/config_dio.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit({required this.dio}) : super(const NewsState(error: 'error'));
  final Dio dio;

  Future<void> getNews() async {
    final results = await DioClient().fetchNews();
    if (state.status == NewsStatus.initial) {
      final listResults = results;
      return emit(
          state.copyWith(status: NewsStatus.success, results: listResults));
    }
    return emit(state.copyWith(
      status: NewsStatus.failure,
      error: state.error,
    ));
  }
}
