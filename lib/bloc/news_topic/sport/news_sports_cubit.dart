import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news_topic/sport/news_sports_state.dart';
import 'package:news_app/dio/config_dio.dart';

class NewsSportsCubit extends Cubit<NewsSportsState> {
  NewsSportsCubit({required this.dio})
      : super(const NewsSportsState(error: ''));

  final Dio dio;
  Future<void> getNews() async {
    final base = await DioClient().fetchNewsWithTopics('sports');

    if (base.data != null) {
      emit(NewsSportsState.success(base.data));
    } else {
      emit(NewsSportsState.failure(base.error!));
    }
  }
}
