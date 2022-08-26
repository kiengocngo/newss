import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news/news_state.dart';
import 'package:news_app/dio/config_dio.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit({required this.dio}) : super(const NewsState.initial());
  final Dio dio;

  Future<void> getNews() async {
    final base = await DioClient().fetchNews();

    if (base.data != null) {
      emit(NewsState.success(base.data));
    } else {
      emit(NewsState.failure(base.error!));
    }
  }
}
