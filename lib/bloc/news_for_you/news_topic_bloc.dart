import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news_for_you/news_topic_event.dart';
import 'package:news_app/dio/config_dio.dart';
import 'news_topic_state.dart';

class NewsTopicsBloc extends Bloc<NewsTopicsEvent, NewsTopicsState> {
  NewsTopicsBloc({required this.dio}) : super(const NewsTopicsState.initial()) {
    on<NewsForYou>(_onNewsForYou);
  }
  final Dio dio;

  Future<void> _onNewsForYou(
      NewsForYou event, Emitter<NewsTopicsState> emit) async {
    final base = await DioClient().fetchNewsForYou(event.listCategories);
    if (base.data != null) {
      emit(NewsTopicsState.success(base.data));
    } else {
      emit(NewsTopicsState.failure(base.error!));
    }
  }
}
