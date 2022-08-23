import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/dio/config_dio.dart';
import 'package:news_app/src/models/news/results_model.dart';
import 'more_news_state.dart';

class MoreNewsCubit extends Cubit<MoreNewsState> {
  MoreNewsCubit(this.dioClient) : super(NewsInitial());
  final DioClient dioClient;
  int page = 1;

  void loadPost() {
    if (state is NewsLoading) return;
    final currentState = state;
    var oloNews = <Results>[];
    if (currentState is NewsLoaded) {
      oloNews = currentState.results;
    }
    emit(NewsLoading(oloNews, isFirstFetch: page == 1));
    dioClient.fetchNewsPage(page).then((newNews) {
      page++;
      final results = (state as NewsLoading).oldNews;
      results.addAll(newNews);
      emit(NewsLoaded(results));
    });
  }
}
