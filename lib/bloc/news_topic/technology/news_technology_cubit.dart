import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news_topic/technology/new_technology_state.dart';
import 'package:news_app/dio/dio.dart';

class NewsTechnologyCubit extends Cubit<NewsTechnologyState> {
  NewsTechnologyCubit({required this.dio})
      : super(const NewsTechnologyState(error: ''));

  final Dio dio;
  Future<void> getNews() async {
    final base = await DioClient().fetchNewsWithTopics('technology');
    if (base.data != null) {
      emit(NewsTechnologyState.success(base.data));
    } else {
      emit(NewsTechnologyState.failure(base.error!));
    }
  }
}
