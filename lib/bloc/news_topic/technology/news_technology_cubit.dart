import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news/news_status.dart';
import 'package:news_app/bloc/news_topic/technology/new_technology_state.dart';
import 'package:news_app/dio/config_dio.dart';

class NewsTechnologyCubit extends Cubit<NewsTechnologyState> {
  NewsTechnologyCubit({required this.dio})
      : super(const NewsTechnologyState(error: ''));

  final Dio dio;
  Future<void> getNews() async {
    final base = await DioClient().fetchNewsWithTopics('technology');
    if (base.data != null) {
      emit(state.copyWith(status: NewsStatus.success, results: base.data));
    } else {
      emit(state.copyWith(
        status: NewsStatus.failure,
        error: base.error,
      ));
    }
  }
}
