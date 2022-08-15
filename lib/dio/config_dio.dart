import 'package:dio/dio.dart';
import 'package:news_app/dio/dio_exception.dart';
import 'package:news_app/src/models/news/news_model.dart';
import 'package:news_app/src/models/news/results_model.dart';

import 'end_point.dart';

class DioClient {
  DioClient()
      : _dio = Dio(BaseOptions(
          baseUrl: Endpoints.baseURL,
          connectTimeout: Endpoints.connectionTimeout,
          receiveTimeout: Endpoints.receiveTimeout,
          queryParameters: {"language": "en"},
        ));

  final Dio _dio;

  Future<List<Results>?> fetchNews() async {
    try {
      final response =
          await _dio.get('/news?apikey=${Endpoints.apiKey}');
      var news = News.fromJson(response.data);
      List<Results>? listResults = news.results;
      return listResults;
    } on DioError catch (err) {
      final errorMesage = DioException.fromDioError(err).toString();
      throw errorMesage;
    }
  }
}
