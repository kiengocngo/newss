import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news/news_state.dart';
import 'package:news_app/bloc/news/news_status.dart';
import 'package:news_app/dio/config_dio.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit({required this.dio}) : super(const NewsState(error: ''));
  final Dio dio;

  Future<void> getNews() async {
    final base = await DioClient().fetchNews();

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
