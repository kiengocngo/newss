import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/dio/config_dio.dart';
import 'package:news_app/src/models/news/results_model.dart';
import 'more_news_state.dart';

class MoreNewsCubit extends Cubit<MoreNewsState> {
  MoreNewsCubit(this.dioClient) : super(NewsInitial());
  final DioClient dioClient;
  int page = 0;
  List<Results> list = [];

  void loadPost() {
    if (state is NewsLoading) return;
    final currentState = state;

    if (currentState is NewsLoaded) {
      list = currentState.results;
    }
    emit(NewsLoading(list, isFirstFetch: page == 0));
    dioClient.fetchNewsPage(page).then((newNews) {
      if (page < 4) {
        page++;
        final results = (state as NewsLoading).oldNews;
        results.addAll(newNews);
        emit(NewsLoaded(results));
      }
    });
  }
}
