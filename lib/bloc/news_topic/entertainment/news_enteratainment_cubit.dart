import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news_topic/entertainment/news_entertainment_state.dart';
import 'package:news_app/dio/config_dio.dart';

class NewsEntertainmentCubit extends Cubit<NewsEntertainmentState> {
  NewsEntertainmentCubit({required this.dio})
      : super(const NewsEntertainmentState(error: ''));

  final Dio dio;
  Future<void> getNews() async {
    final base = await DioClient().fetchNewsWithTopics('entertainment');
    if (base.data != null) {
      emit(NewsEntertainmentState.success(base.data));
    } else {
      emit(NewsEntertainmentState.failure(base.error!));
    }
  }
}
